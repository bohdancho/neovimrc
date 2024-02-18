local capabilities =
    vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())
local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    require("lsp_signature").on_attach({}, bufnr)
    require("bohdancho.mappings").load("lspconfig", { buffer = bufnr })
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        {
            "williamboman/mason-lspconfig.nvim",
            config = function()
                require("mason-lspconfig").setup {
                    ensure_installed = { "lua_ls", "vtsls", "emmet_ls", "tailwindcss" },
                }
            end,
        },
        "yioneko/nvim-vtsls",
        "nvim-lua/plenary.nvim", -- used for bohdancho.renamer
        {
            "ray-x/lsp_signature.nvim",
        },
    },
    config = function()
        local lspconfig = require "lspconfig"
        -- set default server config, optional but recommended
        require("lspconfig.configs").vtsls = require("vtsls").lspconfig

        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                            [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        }
        lspconfig.vtsls.setup { capabilities = capabilities, on_attach = on_attach }
        lspconfig.emmet_ls.setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- expand only on hotkey (excluded from snippets list)
                vim.keymap.set("i", "<C-e>", function()
                    client.request("textDocument/completion", vim.lsp.util.make_position_params(), function(_, result)
                        local textEdit = result[1].textEdit
                        local snip_string = textEdit.newText
                        textEdit.newText = ""
                        vim.lsp.util.apply_text_edits({ textEdit }, bufnr, client.offset_encoding)
                        require("luasnip").lsp_expand(snip_string)
                    end, bufnr)
                end)

                on_attach(client, bufnr)
            end,
        }
        lspconfig.tailwindcss.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                -- add autocomplete in unusual places for classes like cva
                tailwindCSS = { experimental = { classRegex = { { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" } } } },
            },
        }
    end,
}
