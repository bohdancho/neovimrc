local M = {}

local mappings = {}
mappings.general = {
    n = {
        -- moving around panes
        ["<C-h>"] = { "<C-w>h" },
        ["<C-l>"] = { "<C-w>l" },
        ["<C-j>"] = { "<C-w>j" },
        ["<C-k>"] = { "<C-w>k" },

        ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
        ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

        -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
        -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
        -- empty mode is same as using <cmd> :map
        -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
        ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
        ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
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

mappings.lspconfig = {
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
                require("nvchad.renamer").open()
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

M.load = function(sectionName)
    for mode, mode_values in pairs(mappings[sectionName]) do
        for keybind, mapping_info in pairs(mode_values) do
            local opts = mapping_info.opts or {}
            opts.desc = mapping_info[2]

            vim.keymap.set(mode, keybind, mapping_info[1], opts)
        end
    end
end

return M
