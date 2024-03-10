return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    opts = {
        keymaps = { normal = "s" }, -- surround with `s` instead of `ys`
        aliases = {
            -- closing chars don't create whitespace, so alias opening chars to them
            ["<"] = ">",
            ["("] = ")",
            ["{"] = "}",
            ["["] = "]",
        },
    },
}
