return {
    "nvimtools/none-ls.nvim",
    commit = "1dad329b3899413e7e8e03412b2489dbcda5f7e4",
    dependencies = {
        "williamboman/mason.nvim",
        {
            "jay-babu/mason-null-ls.nvim",
            config = function()
                require("mason-null-ls").setup {
                    ensure_installed = {
                        "stylua",
                        "eslint_d",
                        "prettierd",
                    },
                }
            end,
        },
    },
    config = function()
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local null_ls = require "null-ls"

        local formatting = null_ls.builtins.formatting
        local diagnostics = null_ls.builtins.diagnostics

        null_ls.setup {
            sources = {
                formatting.stylua,
                diagnostics.eslint_d.with {
                    condition = function(utils)
                        return utils.root_has_file { ".eslintrc.js", ".eslintrc.cjs" } -- only enable if root has .eslintrc.js or .eslintrc.cjs
                    end,
                },
                formatting.prettierd,
            },

            -- autoformat on save
            on_attach = function(client, bufnr)
                vim.api.nvim_create_user_command("FormatOnSave", function(opts)
                    vim.g.format_on_save = vim.fn.json_decode(opts.fargs[1])
                end, { nargs = 1 })

                if client.supports_method "textDocument/formatting" then
                    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            if vim.g.format_on_save ~= false then
                                vim.lsp.buf.format { bufnr = bufnr }
                            end
                        end,
                    })
                end
            end,
        }
    end,
}
