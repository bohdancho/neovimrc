local function border(hl_name)
    return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
    }
end

return {
    "hrsh7th/nvim-cmp",
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        {
            -- snippet plugin
            "L3MON4D3/LuaSnip",
            dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
                require("luasnip").config.set_config(opts)

                -- vscode format
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

                -- snipmate format
                require("luasnip.loaders.from_snipmate").load()
                require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

                -- lua format
                require("luasnip.loaders.from_lua").load()
                require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
            end,
        },

        -- cmp sources plugins
        {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        "onsails/lspkind.nvim", -- icons
    },
    config = function()
        local cmp = require "cmp"

        local config = {}
        config.snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        }
        config.window = {
            completion = cmp.config.window.bordered {
                border = border "BohdanchoBorder",
                scrollbar = false,
            },
            documentation = {
                border = border "BohdanchoBorder",
            },
        }
        config.completion = { completeopt = "menu,menuone,noinsert" }
        config.formatting = {
            format = require("lspkind").cmp_format {
                mode = "symbol", -- show only symbol annotations
                maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                ellipsis_char = "...",
                show_labelDetails = true,
            },
        }
        config.mapping = {
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-y>"] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.confirm { select = true }
                else
                    require("luasnip").jump(1)
                end
            end),
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
        }
        config.sources = {
            {
                name = "nvim_lsp",
                entry_filter = function(entry)
                    if
                        entry:get_kind() == require("cmp.types").lsp.CompletionItemKind.Snippet
                        and entry.source:get_debug_name() == "nvim_lsp:emmet_ls"
                    then
                        return false
                    end
                    return true
                end,
            },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "nvim_lua" },
            { name = "path" },
        }
        cmp.setup(config)

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                {
                    name = "cmdline",
                    option = {
                        ignore_cmds = { "Man", "!" },
                    },
                },
            }),
        })
    end,
}
