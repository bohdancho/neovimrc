return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require "lint"

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
        }

        local eslint = lint.linters.eslint_d
        eslint.args = {
            "--no-warn-ignored", -- so I don't get annoying errors when no eslint config is found
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
