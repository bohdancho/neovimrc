local mappings = require "mappings"

return {
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        keys = {
            { "<leader>gl", "<cmd> LazyGit <CR>", desc = "[G]it [L]azy" },
        },
        config = function()
            require("lazy").setup {
                {
                    "kdheepak/lazygit.nvim",
                    -- optional for floating window border decoration
                    dependencies = {
                        "nvim-lua/plenary.nvim",
                    },
                },
            }
            vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = "#303340" })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "󰍵" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "│" },
            },
            on_attach = function(bufnr)
                mappings.load("gitsigns", { buffer = bufnr })
            end,
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    {
        "tpope/vim-fugitive",
        lazy = true,
        keys = {
            { "<leader>gd", "<cmd> Gvdiff <CR>", desc = "[G]it [D]iff" },
        },
        cmd = {
            "G",
        },
    },
}
