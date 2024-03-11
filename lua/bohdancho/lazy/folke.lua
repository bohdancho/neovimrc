return {
    {
        "folke/trouble.nvim",
        lazy = false,
        keys = {
            { "<leader>tr", "<cmd>TroubleToggle<cr>", desc = "[T][r]ouble toggle" },
        },
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        keys = {
            { "<leader>td", "<cmd>TodoQuickFix <CR>", desc = "[T]o[d]o quickfix" },
        },
        opts = {},
    },
}
