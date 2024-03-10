local M

local mappings = require "bohdancho.mappings"
local mappings_gitsigns

M = {
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
        event = { "BufReadPre", "BufNewFile" },
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
                mappings.load_table(mappings_gitsigns, { buffer = bufnr })
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
            { "<leader>gh", "<cmd> 0GcLog <CR>", desc = "[G]it file [H]istory" },
        },
        cmd = {
            "G",
        },
    },
}

mappings_gitsigns = {
    n = {
        -- Navigation through hunks
        ["]c"] = {
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to next hunk",
            opts = { expr = true },
        },

        ["[c"] = {
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to prev hunk",
            opts = { expr = true },
        },

        -- Actions
        ["<leader>hr"] = {
            function()
                require("gitsigns").reset_hunk()
            end,
            "[H]unk [R]eset",
        },

        ["<leader>hp"] = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "[H]unk [P]review",
        },
    },
}

return M
