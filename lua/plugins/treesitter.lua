return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require "nvim-treesitter.configs"

        configs.setup {
            auto_install = true,
            highlight = {
                enable = true,
                disable = { "lua" },
            },
            indent = {
                enable = true,
            },
        }
    end,
}
