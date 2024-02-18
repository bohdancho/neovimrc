local M = {}

---@alias ModuleName 'general' | 'lspconfig' | 'gitsigns'
---@type ModuleName
local mappings = {}
mappings["general"] = {
    n = {
        -- moving around panes
        ["<C-h>"] = { "<C-w>h" },
        ["<C-l>"] = { "<C-w>l" },
        ["<C-j>"] = { "<C-w>j" },
        ["<C-k>"] = { "<C-w>k" },

        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    },

    v = {
        -- Don't copy the replaced text after pasting in visual mode
        -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
        ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
    },

    i = {
        -- navigate within insert mode
        ["<C-h>"] = { "<Left>", "Move left" },
        ["<C-l>"] = { "<Right>", "Move right" },
        ["<C-j>"] = { "<Down>", "Move down" },
        ["<C-k>"] = { "<Up>", "Move up" },
    },

    t = {
        ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
    },
}

mappings["lspconfig"] = {
    n = {
        ["gd"] = {
            function()
                vim.lsp.buf.definition()
            end,
            "LSP definition",
        },

        ["gr"] = {
            function()
                require("telescope.builtin").lsp_references()
            end,
            "lsp references",
        },

        ["K"] = {
            function()
                vim.lsp.buf.hover()
            end,
            "LSP hover",
        },

        ["<leader>lr"] = {
            function()
                require("bohdancho.renamer").open()
            end,
            "[L]SP [r]ename",
        },

        ["<leader>la"] = {
            function()
                vim.lsp.buf.code_action()
            end,
            "[L]SP code [a]ction",
        },

        ["<leader>d"] = {
            function()
                vim.diagnostic.open_float { border = "rounded" }
            end,
            "Floating [d]iagnostic",
        },

        ["[d"] = {
            function()
                vim.diagnostic.goto_prev { float = { border = "rounded" } }
            end,
            "Goto prev",
        },

        ["]d"] = {
            function()
                vim.diagnostic.goto_next { float = { border = "rounded" } }
            end,
            "Goto next",
        },
    },
}

mappings["gitsigns"] = {
    n = {
        -- Navigation through hunks
        ["]c"] = {
            function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    require("gitsigns").next_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to next hunk",
            opts = { expr = true },
        },

        ["[c"] = {
            function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    require("gitsigns").prev_hunk()
                end)
                return "<Ignore>"
            end,
            "Jump to prev hunk",
            opts = { expr = true },
        },

        -- Actions
        ["<leader>hr"] = {
            function()
                require("gitsigns").reset_hunk()
            end,
            "[H]unk [R]eset",
        },

        ["<leader>hp"] = {
            function()
                require("gitsigns").preview_hunk()
            end,
            "[H]unk [P]review",
        },
    },
}

---@param sectionName ModuleName
---@param mapping_opt table | nil
M.load = function(sectionName, mapping_opt)
    for mode, mode_values in pairs(mappings[sectionName]) do
        for keybind, mapping_info in pairs(mode_values) do
            local opts = vim.tbl_deep_extend("force", mapping_info.opts or {}, mapping_opt or {})
            opts.desc = mapping_info[2]

            vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
    end
end

return M
