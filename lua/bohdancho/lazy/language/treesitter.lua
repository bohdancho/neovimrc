return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-context",
    },
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require "nvim-treesitter.configs"

        require("treesitter-context").setup {
            multiline_threshold = 1, -- Maximum number of lines to show for a single context
        }

        ---@diagnostic disable-next-line: missing-fields
        configs.setup {
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "lua" },
            },
            indent = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        }
    end,
}
