return {
    "akinsho/toggleterm.nvim",
    lazy = true,
    keys = {
        -- toggle in terminal mode
        { "<A-h>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" } },
    },
    config = function()
        require("toggleterm").setup()
    end,
}
