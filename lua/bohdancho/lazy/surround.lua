return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    keys = { "s" },
    opts = {
        keymaps = {
            -- surround with `s` instead of `ys`
            normal = "s",
            visual = "s",
            visual_line = "s",

            delete = "sd",
            change = "sc",
            change_line = "sC",
        },
        aliases = {
            -- closing chars don't create whitespace, so alias opening chars to them
            ["<"] = ">",
            ["("] = ")",
            ["{"] = "}",
            ["["] = "]",
            ["q"] = '"',
        },
        surrounds = {
            ["z"] = {
                add = function()
                    return { { "<>" }, { "</>" } }
                end,
            },
        },
    },
}
