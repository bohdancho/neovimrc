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
        filetypes = {
            go = false,
            rust = false,
        },
    },
    config = function(_, opts)
        -- I don't want to use it for now
        -- require("copilot").setup(opts)
    end,
}
