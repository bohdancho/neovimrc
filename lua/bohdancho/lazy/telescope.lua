return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd> Telescope find_files hidden=true <CR>", desc = "Find files" },
            { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
            { "<leader>fw", "<cmd> Telescope live_grep hidden=true <CR>", desc = "Live grep" },
            {
                "<leader>fu",
                function()
                    require("telescope.builtin").grep_string {
                        default_text = vim.fn.expand "<cword>",
                    }
                end,
                desc = "Live grep the word [U]nder cursor",
            },
            { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
            { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
            { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
            { "<leader>fs", "<cmd> Telescope lsp_workspace_symbols <CR>", desc = "Find workspace symbols" },
            { "<leader>fb", "<cmd> Telescope builtin <CR>", desc = "Find builtin" },
            { "<leader>fr", "<cmd> Telescope resume <CR>", desc = "Find resume" },

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

                            -- change mode to normal and paste from system buffer
                            ["<C-v"] = function()
                                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
                                vim.cmd 'normal! "*p'
                            end,
                        },
                    },
                    file_ignore_patterns = { "%.git/" },
                },
                pickers = {
                    live_grep = {
                        additional_args = function()
                            return {
                                "--hidden",
                                "--glob",
                                "!{**/.git/*,**/node_modules/*,**/*-lock.*,**/yarn.lock}",
                            }
                        end,
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
