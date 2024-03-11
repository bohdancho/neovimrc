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
            vim.api.nvim_set_hl(0, "LazyGitBorder", { link = "BohdanchoBorder" })
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
                local gs = require "gitsigns"

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation through hunks
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(gs.next_hunk)
                    return "<Ignore>"
                end, { desc = "Jump to next hunk", expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(gs.prev_hunk)
                    return "<Ignore>"
                end, { desc = "Jump to prev hunk", expr = true })

                map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
                map("n", "<leader>hs", gs.stage_hunk)
                map("n", "<leader>hu", gs.undo_stage_hunk)

                map("v", "<leader>hs", function()
                    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)
                map("v", "<leader>hr", function()
                    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hR", gs.reset_buffer)
            end,
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end,
    },
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gd", "<cmd> Gvdiff <CR>", desc = "[G]it [D]iff" },
            { "<leader>gh", "<cmd> 0GcLog <CR>", desc = "[G]it file [H]istory" },
            { "<leader>gf", "<cmd> G <CR>", desc = "[G]it [F]ugitive" },
        },
        cmd = {
            "G",
        },
    },
    { "rhysd/git-messenger.vim", keys = { { "<leader>gm", desc = "[G]it [M]essenger" } } },
}
