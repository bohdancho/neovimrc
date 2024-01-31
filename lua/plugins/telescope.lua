return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "VeryLazy",
        keys = {
            { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
            { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
            { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
            { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
            { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
            { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },

            -- git
            { "<leader>gc", "<cmd> Telescope git_commits <CR>", desc = "[G]it [c]ommits" },
            { "<leader>gs", "<cmd> Telescope git_status <CR>", desc = "[G]it [s]tatus" },
        },
        config = function()
            local telescope = require "telescope"
            telescope.setup {
                defaults = {
                    preview = {
                        treesitter = { disable = { "lua" } },
                    },
                    mappings = {
                        i = {
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                        },
                    },
                },
            }
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local telescope = require "telescope"
            telescope.setup {
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {},
                    },
                },
            }
            telescope.load_extension "ui-select"
        end,
    },
}
