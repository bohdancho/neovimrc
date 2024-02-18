return {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    build = ":Copilot auth",
    opts = {
        suggestion = {
            auto_trigger = true,
            keymap = {
                accept = "<C-p>",
            },
        },
    },
    config = function(_, opts)
        require("copilot").setup(opts)
    end,
}
