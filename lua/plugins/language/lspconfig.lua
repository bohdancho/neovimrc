local capabilities =
    vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

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
    },
    config = function()
        require("mappings").load "lspconfig"

        local lspconfig = require "lspconfig"
        -- set default server config, optional but recommended
        require("lspconfig.configs").vtsls = require("vtsls").lspconfig

        lspconfig.lua_ls.setup {
            capabilities = capabilities,
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
        lspconfig.vtsls.setup { capabilities = capabilities }
        lspconfig.emmet_ls.setup { capabilities = capabilities }
        lspconfig.tailwindcss.setup {
            capabilities = capabilities,
            settings = {
                -- add autocomplete in unusual places for classes like cva
                tailwindCSS = { experimental = { classRegex = { { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" } } } },
            },
        }
    end,
}
