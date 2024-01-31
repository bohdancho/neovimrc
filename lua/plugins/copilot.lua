return {
    "zbirenbaum/copilot.lua",
    lazy = true,
    build = ":Copilot auth",
    keys = {
        {
            "<M-Bslash>",
            nil,
            mode = "i",
        },
    },
    opts = {
        suggestion = {
            keymap = {
                next = "<M-Bslash>",
                accept = "<Tab>",
            },
        },
    },
    config = function(_, opts)
        require("copilot").setup(opts)
    end,
}
