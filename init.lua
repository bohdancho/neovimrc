vim.g.mapleader = " "
require "bohdancho.mappings"
require "bohdancho.options"
require "bohdancho.autocmds"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "bohdancho.lazy" },
    { import = "bohdancho.lazy.language" },
    {
        "ThePrimeagen/vim-apm",
        config = function()
            local apm = require "vim-apm"

            apm:setup {}
            vim.keymap.set("n", "<leader>apm", function()
                apm:toggle_monitor()
            end)
        end,
    },
}, {
    change_detection = {
        notify = false,
    },
})
