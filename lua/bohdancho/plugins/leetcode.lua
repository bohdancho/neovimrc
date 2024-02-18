local leet_arg = "leetcode.nvim"
return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    lazy = leet_arg ~= vim.fn.argv()[1], -- no lazy if called with `nvim leetcode.nvim`
    cmd = "Leet",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        -- "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("leetcode").setup { arg = leet_arg, lang = "typescript" }
    end,
}
