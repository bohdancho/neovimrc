return {
    "folke/trouble.nvim",
    keys = {
        { "<leader>tr", "<cmd>TroubleToggle<cr>", desc = "[T][r]ouble toggle" },
    },
    config = function()
        require("trouble").setup {}
    end,
}
