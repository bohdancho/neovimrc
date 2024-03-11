return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "Find files" },
            { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
            { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "Live grep" },
            {
                "<leader>f",
                '"zy <cmd>exec "Telescope grep_string default_text=" . escape(@z, " ")<CR>',
                desc = "Live grep selected",
                mode = "v",
            },
            { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
            { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
            { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
            { "<leader>fs", "<cmd> Telescope lsp_workspace_symbols <CR>", desc = "Find workspace symbols" },
            { "<leader>fb", "<cmd> Telescope builtin <CR>", desc = "Find builtin" },
            { "<leader>fr", "<cmd> Telescope resume <CR>", desc = "Find resume" },

            -- git
            { "<leader>gc", "<cmd> Telescope git_commits <CR>", desc = "[G]it [c]ommits" },
            { "<leader>gs", "<cmd> Telescope git_status <CR>", desc = "[G]it [s]tatus" },
        },
        config = function()
            local telescope = require "telescope"
            telescope.setup {
                defaults = {
                    layout_strategy = "vertical",
                    layout_config = {
                        preview_cutoff = 0,
                    },
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--fixed-strings", -- raw strings, no regex
                    },
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
