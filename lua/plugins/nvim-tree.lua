return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree" },
    },
    lazy = true,
    opts = {
        update_focused_file = {
            enable = true,
        },
        view = {
            adaptive_size = true,
        },
        renderer = {
            root_folder_label = false,
            highlight_git = false,
            highlight_opened_files = "none",

            indent_markers = {
                enable = false,
            },

            icons = {
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = false,
                },

                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_open = "",
                        arrow_closed = "",
                        default = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "",
                        staged = "S",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "U",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
        },
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
}
