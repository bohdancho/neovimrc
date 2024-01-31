return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require "harpoon"

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():append()
        end)
        vim.keymap.set("n", "<leader>hl", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "N", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "M", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", ">", function()
            harpoon:list():select(4)
        end)
    end,
}
