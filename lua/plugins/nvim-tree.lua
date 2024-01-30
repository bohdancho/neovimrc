return {
    "nvim-tree/nvim-tree.lua",
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
                    default = "󰈚",
                    symlink = "",
                    folder = {
                        default = "",
                        empty = "",
                        empty_open = "",
                        open = "",
                        symlink = "",
                        symlink_open = "",
                        arrow_open = "",
                        arrow_closed = "",
                    },
                    git = {
                        unstaged = "✗",
                        staged = "✓",
                        unmerged = "",
                        renamed = "➜",
                        untracked = "★",
                        deleted = "",
                        ignored = "◌",
                    },
                },
            },
        },
    },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
    end,
    keys = {
        { "<C-n>", "<cmd> NvimTreeToggle <CR>", desc = "Toggle nvimtree" },
    },
}
