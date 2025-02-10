-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
        "bullets-vim/bullets.vim",
        ft = "markdown",
    },
    {
        "laytan/cloak.nvim",
        priority = 1000,
        opts = {}
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "tokyonight-night"
            vim.api.nvim_set_hl(0, "BohdanchoBorder", { bg = "NONE", fg = "#27a1b9" })
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "-",
                function()
                    require("oil").open_float()
                end,
                desc = "Open file tree",
            },
        },
        opts = {
            keymaps = {
                ["q"] = "actions.close",
            },
            view_options = {
                show_hidden = true,
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "󰍵" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "│" },
            },
            on_attach = function(bufnr)
                local gs = require "gitsigns"

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation through hunks
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(gs.next_hunk)
                    return "<Ignore>"
                end, { desc = "Jump to next hunk", expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(gs.prev_hunk)
                    return "<Ignore>"
                end, { desc = "Jump to prev hunk", expr = true })

                map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [R]eset" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
                map("n", "<leader>hs", gs.stage_hunk)
                map("n", "<leader>hu", gs.undo_stage_hunk)

                map("v", "<leader>hs", function()
                    gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)
                map("v", "<leader>hr", function()
                    gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
                end)
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hR", gs.reset_buffer)
            end,
        },
    },
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>gd", "<cmd> Gvdiff <CR>", desc = "[G]it [D]iff" },
            { "<leader>gh", "<cmd> 0GcLog <CR>", desc = "[G]it file [H]istory" },
            { "<leader>gf", "<cmd> G <CR>", desc = "[G]it [F]ugitive" },
        }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require "harpoon"
            harpoon:setup()

            vim.keymap.set("n", "<leader>ha", function()
                harpoon:list():add()
            end)
            vim.keymap.set("n", "<leader>hl", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set("n", "<leader>h1", function()
                harpoon:list():select(1)
            end)
            vim.keymap.set("n", "<leader>h2", function()
                harpoon:list():select(2)
            end)
            vim.keymap.set("n", "<leader>h3", function()
                harpoon:list():select(3)
            end)
            vim.keymap.set("n", "<leader>h4", function()
                harpoon:list():select(4)
            end)
        end,
    },
    {
        "tzachar/highlight-undo.nvim",
        keys = { "u", "<C-r>" },
        opts = {},
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
            }
        }
    },
    {
        "nmac427/guess-indent.nvim",
        opts = {}
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        opts = {}
    },
    {
        "kylechui/nvim-surround",
        keys = { "s" },
        opts = {
            keymaps = {
                -- surround with `s` instead of `ys`
                normal = "s",
                visual = "s",
                visual_line = "s",

                delete = "sd",
                change = "sc",
            },
            aliases = {
                -- opening chars create unwanted whitespace, i.e. `( content )` instead of `(content)`, closing chars don't do this, so alias opening chars to closed
                ["<"] = ">",
                ["("] = ")",
                ["{"] = "}",
                ["["] = "]",
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
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


-- disable autocomments on new line
vim.cmd "autocmd BufEnter * set formatoptions-=cro"
vim.cmd "autocmd BufEnter * setlocal formatoptions-=cro"

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("bohdancho-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<leader>q", "<C-w>q")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
vim.keymap.set("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "Move down", expr = true })
vim.keymap.set("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "Move up", expr = true })

vim.keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })

vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), { desc = "Escape terminal mode" })

vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", { desc = "Quickfix previous" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Quickfix next" })

vim.keymap.set("n", "<leader>cwc", "sa'(sa({acn<C-C><C-C>l%i,<Space>", { remap = true, desc = "[C]ode [W]rap with [c]n" })

vim.keymap.set(
    "n",
    "<leader>lq",
    [[<cmd>cexpr systemlist('bunx tsc | grep -o "src/[^\(]*" | sed "s/$/:0:0/" | uniq')<cr><cmd>copen<cr>]],
    { desc = "LSP: tsc [q]uickfix" }
)

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.fillchars = { eob = " " }
vim.opt.scrolloff = 8

vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.guicursor = "n-v-c-i:block"

-- TODO: check if this works
vim.opt.conceallevel = 2
vim.keymap.set(
    "n",
    "<leader>tc",
    ":setlocal <C-R>=&conceallevel ? 'conceallevel=0' : 'conceallevel=2'<CR><CR>",
    { desc = "[T]oggle [C]onceallevel" }
)

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.expandtab = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- ignore case unless there is a capital letter
vim.opt.ignorecase = true
vim.opt.smartcase = true
