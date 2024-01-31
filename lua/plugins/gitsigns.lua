local mappings = require "mappings"

return {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    event = "VeryLazy",
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
            mappings.load("gitsigns", { buffer = bufnr })
        end,
    },
    config = function(_, opts)
        require("gitsigns").setup(opts)
    end,
}
