vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.fillchars = { eob = " " }
vim.opt.scrolloff = 8

vim.opt.hlsearch = true
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.guicursor = "n-v-c-i:block"

vim.opt.conceallevel = 2
vim.keymap.set(
    "n",
    "<leader>tc",
    ":setlocal <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=2'<CR><CR>",
    { desc = "[T]oggle [C]onceallevel" }
)

local is_wsl = vim.api.nvim_eval 'has("wsl")' == 1
if is_wsl then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- ignore case unless there is a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true
