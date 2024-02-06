return {
    "folke/trouble.nvim",
    keys = {
        { "<leader>tl", "<cmd>TroubleToggle<cr>" },
    },
    lazy = true,
    config = function()
        require("trouble").setup {}
    end,
}
