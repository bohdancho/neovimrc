return {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    keys = {
        { "gcc" },
        { "gc", mode = { "n", "v" } },
        { "gb", mode = { "n", "v" } },
    },
    config = function()
        require("Comment").setup {
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        }
    end,
}
