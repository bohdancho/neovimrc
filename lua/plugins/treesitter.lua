return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local configs = require "nvim-treesitter.configs"

        configs.setup {
            ensure_installed = {
                -- defaults
                "lua",
                "vimdoc",

                -- web dev
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                "json",
                "php",

                "make",
                "markdown",
                "bash",
            },
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
