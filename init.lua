-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
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
vim.g.maplocalleader = " "

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
    "<leader>tq",
    [[<cmd>cexpr systemlist('bunx tsc | grep -o "src/[^\(]*" | sed "s/$/:0:0/" | uniq')<cr><cmd>copen<cr>]],
    { desc = "[T]ypescript: [q]uickfix" }
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

-- Setup lazy.nvim
---@type LazyConfig
require("lazy").setup {
    defaults = {
        version = "*",
    },
    ---@type LazySpec
    spec = {
        {
            "bullets-vim/bullets.vim",
            ft = "markdown",
        },
        {
            "laytan/cloak.nvim",
            priority = 1000,
            lazy = false,
            opts = {},
            keys = {
                {
                    "<leader>cc",
                    "<cmd>CloakToggle<cr>",
                    desc = "Cloak toggle",
                },
            },
        },
        {
            "folke/tokyonight.nvim",
            priority = 1000,
            lazy = false,
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
                    "+",
                    "<cmd>Oil<cr>",
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
            "mikavilpas/yazi.nvim",
            dependencies = { "folke/snacks.nvim" },
            keys = {
                {
                    "-",
                    mode = { "n", "v" },
                    "<cmd>Yazi<cr>",
                    desc = "Open yazi at the current file",
                },
                {
                    -- Open in the current working directory
                    "<leader>cw",
                    "<cmd>Yazi cwd<cr>",
                    desc = "Open the file manager in nvim's working directory",
                },
            },
            ---@type YaziConfig | {}
            opts = {
                -- if you want to open yazi instead of netrw, see below for more info
                open_for_directories = true,
                keymaps = {
                    show_help = "<f1>",
                },
            },
            -- 👇 if you use `open_for_directories=true`, this is recommended
            init = function()
                -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
                -- vim.g.loaded_netrw = 1
                vim.g.loaded_netrwPlugin = 1
            end,
        },
        {
            "lewis6991/gitsigns.nvim",
            ft = { "gitcommit", "diff" },
            event = { "BufReadPre", "BufNewFile" },
            opts = {
                signs = {
                    add = { text = "+" },
                    change = { text = "│" },
                    delete = { text = "󰍵" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "│" },
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
            },
        },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" },
            keys = { "<leader>ha", "<leader>hl", "<leader>h1", "<leader>h2", "<leader>h3", "<leader>h4", "<leader>h5", "<leader>h6" },
            config = function()
                local harpoon = require "harpoon"
                harpoon:setup()

                vim.keymap.set("n", "<leader>ha", function()
                    harpoon:list():append()
                end)
                vim.keymap.set("n", "<leader>hl", function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end)

                for i = 1, 6 do
                    vim.keymap.set("n", "<leader>h" .. i, function()
                        harpoon:list():select(i)
                    end)
                end
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
            event = "VeryLazy",
            opts = {
                indent = {
                    char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
                },
            },
        },
        { "tpope/vim-sleuth", event = "VeryLazy" },
        {
            "folke/todo-comments.nvim",
            event = "VeryLazy",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = false },
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            event = "VeryLazy",
            opts = {
                sections = {
                    lualine_c = {
                        { "filename", path = 1 },
                    },
                },
            },
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
        },
        {
            "numToStr/Comment.nvim",
            dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
            keys = {
                { "gcc" },
                { "gc", mode = { "n", "v" } },
                { "gb", mode = { "n", "v" } },
            },
            config = function()
                require("Comment").setup {
                    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
                }
                require("Comment.ft").set("htmlangular", "<!-- %s -->", "<!-- %s -->")
            end,
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope-ui-select.nvim",
            },
            keys = {
                { "<leader>ff", "<cmd> Telescope find_files hidden=true <CR>", desc = "Find files" },
                { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "Find all" },
                { "<leader>fw", "<cmd> Telescope live_grep hidden=true <CR>", desc = "Live grep" },
                { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "Find buffers" },
                { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "Help page" },
                { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "Find in current buffer" },
                { "<leader>fs", "<cmd> Telescope lsp_workspace_symbols <CR>", desc = "Find workspace symbols" },
                { "<leader>fb", "<cmd> Telescope builtin <CR>", desc = "Find builtin" },
                { "<leader>fr", "<cmd> Telescope resume <CR>", desc = "Find resume" },

                { "<leader>gc", "<cmd> Telescope git_commits <CR>", desc = "[G]it [c]ommits" },
                { "<leader>gs", "<cmd> Telescope git_status <CR>", desc = "[G]it [s]tatus" },
            },
            config = function()
                local telescope = require "telescope"
                telescope.setup {
                    defaults = {
                        layout_strategy = "vertical",
                        layout_config = {
                            preview_cutoff = 0,
                        },
                        vimgrep_arguments = {
                            "rg",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--smart-case",
                            "--fixed-strings", -- raw strings, no regex
                        },
                        preview = {
                            treesitter = { disable = { "lua" } },
                        },
                        mappings = {
                            i = {
                                ["<C-j>"] = require("telescope.actions").move_selection_next,
                                ["<C-k>"] = require("telescope.actions").move_selection_previous,

                                -- change mode to normal and paste from system buffer
                                ["<C-v"] = function()
                                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true)
                                    vim.cmd 'normal! "*p'
                                end,
                            },
                        },
                        file_ignore_patterns = { "%.git/" },
                    },
                    pickers = {
                        live_grep = {
                            additional_args = function()
                                return {
                                    "--hidden",
                                    "--glob",
                                    "!{**/.git/*,**/node_modules/*,**/*-lock.*,**/yarn.lock}",
                                }
                            end,
                        },
                    },
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown {},
                        },
                    },
                }
                telescope.load_extension "ui-select"
            end,
        },
        {
            "akinsho/toggleterm.nvim",
            keys = {
                { "<M-h>", "<cmd>ToggleTerm size=20<cr>", mode = { "n", "t" } },
            },
            opts = {},
        },
        {
            "nvim-treesitter/nvim-treesitter",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects",
                -- "nvim-treesitter/nvim-treesitter-context",
                "dlvandenberg/tree-sitter-angular",
            },
            lazy = false,
            build = ":TSUpdate",
            config = function()
                -- require("treesitter-context").setup {
                --     multiline_threshold = 1, -- Maximum number of lines to show for a single context
                -- }

                require("nvim-treesitter.configs").setup {
                    auto_install = true,
                    highlight = {
                        enable = true,
                        disable = { "lua" },
                    },
                    indent = {
                        -- enable = true,
                    },
                    textobjects = {
                        select = {
                            enable = true,
                            lookahead = true,
                            keymaps = {
                                ["af"] = "@function.outer",
                                ["if"] = "@function.inner",
                                ["ac"] = "@class.outer",
                                ["ic"] = "@class.inner",
                            },
                        },
                    },
                }

                vim.filetype.add {
                    pattern = {
                        [".*%.component%.html"] = "htmlangular",
                    },
                }
            end,
        },

        -- LSP
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "williamboman/mason.nvim", opts = {} },
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",

                -- Useful status updates for LSP.
                { "j-hui/fidget.nvim", opts = {} },
                {
                    "yioneko/nvim-vtsls",
                    keys = {
                        {
                            "<leader>ta",
                            "<cmd>VtsExec add_missing_imports<cr>",
                            desc = "[T]typescript [a]dd missing imports",
                        },
                        {
                            "<leader>tr",
                            "<cmd>VtsExec remove_unused_imports<cr>",
                            desc = "[T]typescript [r]emove unused imports",
                        },
                    },
                },
            },
            config = function()
                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
                    callback = function(event)
                        local map = function(keys, func, desc, mode)
                            mode = mode or "n"
                            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                        end

                        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                        map("K", vim.lsp.buf.hover, "Hover")
                        map("<leader>lr", require("bohdancho.renamer").open, "Rename")
                        map("<leader>la", vim.lsp.buf.code_action, "Code Action")
                        map("<leader>d", function()
                            vim.diagnostic.open_float { border = "rounded" }
                        end, "Floating [d]iagnostic")
                        map("[d", function()
                            vim.diagnostic.goto_prev { float = { border = "rounded" } }
                        end, "Goto prev")
                        map("]d", function()
                            vim.diagnostic.goto_next { float = { border = "rounded" } }
                        end, "Goto next")

                        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

                        -- The following code creates a keymap to toggle inlay hints in your
                        -- code, if the language server you are using supports them
                        --
                        -- This may be unwanted, since they displace some of your code
                        -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                        -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
                        --     map("<leader>ih", function()
                        --         vim.print(event.buf)
                        --         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                        --     end, "Toggle [I]nlay [H]ints")
                        -- end
                    end,
                })

                -- Change diagnostic symbols in the sign column (gutter)
                if vim.g.have_nerd_font then
                    local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
                    local diagnostic_signs = {}
                    for type, icon in pairs(signs) do
                        diagnostic_signs[vim.diagnostic.severity[type]] = icon
                    end
                    vim.diagnostic.config { signs = { text = diagnostic_signs } }
                end

                local servers = {
                    lua_ls = {
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        "${3rd}/luv/library",
                                        unpack(vim.api.nvim_get_runtime_file("", true)),
                                    },
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },
                                diagnostics = { disable = { "missing-fields" } },
                            },
                        },
                    },
                    angularls = {
                        on_attach = function()
                            -- both vtsls and angularls have renameProvider so disable it for vtsls
                            local vtsls_client = vim.lsp.get_clients({ name = "vtsls" })[1]
                            if vtsls_client ~= nil then
                                vtsls_client.server_capabilities.renameProvider = false
                            end
                        end,
                    },
                    vtsls = {},
                    emmet_ls = {
                        on_attach = function(client, bufnr)
                            vim.keymap.set("i", "<C-e>", function()
                                client.request("textDocument/completion", vim.lsp.util.make_position_params(), function(_, result)
                                    local textEdit = result[1].textEdit
                                    local snip_string = textEdit.newText

                                    -- remove the inserted text
                                    local start_col = textEdit.range.start.character + 1
                                    vim.fn.cursor(vim.fn.line ".", start_col)
                                    local old_text = result[1].label
                                    vim.cmd.normal { args = { "d" .. #old_text .. "l" } }

                                    -- if the inserted text was the last text on the line, the deletion command will leave the cursor 1 column left
                                    -- of where we need to insert the snippet (because insert mode can put the cursor 1 position ahead of the last column)
                                    -- move the cursor back over 1
                                    vim.fn.cursor(vim.fn.line ".", start_col)
                                    textEdit.newText = ""
                                    vim.lsp.util.apply_text_edits({ textEdit }, bufnr, client.offset_encoding)
                                    vim.snippet.expand(snip_string)
                                end, bufnr)
                            end, { buffer = bufnr, desc = "LSP: Emmet autocomplete" })
                        end,
                    },
                    tailwindcss = {
                        settings = {
                            -- add autocomplete in unusual places for classes like cva
                            tailwindCSS = {
                                experimental = {
                                    classRegex = {
                                        { "tw\\('([^']*)'\\)" }, -- TODO: add support for parens in the class name like calc()
                                        { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                                    },
                                },
                            },
                        },
                    },
                    -- gopls = {
                    --     on_attach = function(_, bufnr)
                    --         vim.keymap.set("n", "<leader>lf", function()
                    --             local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding(bufnr))
                    --             params.context = { only = { "source.organizeImports" } }
                    --
                    --             local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 3000)
                    --             for _, res in pairs(result or {}) do
                    --                 for _, r in pairs(res.result or {}) do
                    --                     if r.edit then
                    --                         vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding(bufnr))
                    --                     else
                    --                         vim.lsp.buf.execute_command(r.command)
                    --                     end
                    --                 end
                    --             end
                    --         end, { buffer = bufnr, desc = "LSP: Gopls [F]ix imports" })
                    --     end,
                    --     settings = {
                    --         gopls = {
                    --             analyses = {
                    --                 unusedparams = true,
                    --                 unreachable = true,
                    --             },
                    --             staticcheck = true,
                    --         },
                    --     },
                    -- },
                    eslint = {
                        filetypes = {
                            "htmlangular",
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                            "vue",
                            "svelte",
                            "astro",
                        },
                        on_attach = function(_, bufnr)
                            vim.keymap.set("n", "<leader>lf", "<cmd>EslintFixAll<CR>", { buffer = bufnr, desc = "LSP: Eslint[F]ixAll" })
                        end,
                    },
                    pyright = {},
                }
                local ensure_installed = vim.tbl_keys(servers or {})

                vim.list_extend(ensure_installed, {
                    "stylua",
                    "prettierd",
                    "sql-formatter",
                    "black",
                    { "angularls", version = "18.2.0" }, -- v19 expects standalone: true default which breaks v18
                })
                require("mason-tool-installer").setup { ensure_installed = ensure_installed }

                require("mason-lspconfig").setup {
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            server.capabilities =
                                vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), server.capabilities or {})
                            require("lspconfig")[server_name].setup(server)
                        end,
                    },
                }
                local border = "rounded"
                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    border = border,
                })
                vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    border = border,
                })
                vim.diagnostic.config {
                    float = { border = border },
                }
            end,
        },
        { -- Autoformat
            "stevearc/conform.nvim",
            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            config = function()
                vim.api.nvim_create_user_command("FormatDisable", function(args)
                    if args.bang then
                        -- FormatDisable! will disable formatting just for this buffer
                        vim.b.disable_autoformat = true
                    else
                        vim.g.disable_autoformat = true
                    end
                end, {
                    desc = "Disable autoformat-on-save",
                    bang = true,
                })

                vim.api.nvim_create_user_command("FormatEnable", function()
                    vim.b.disable_autoformat = false
                    vim.g.disable_autoformat = false
                end, {
                    desc = "Re-enable autoformat-on-save",
                })

                require("conform").setup {
                    notify_on_error = false,
                    format_on_save = function(bufnr)
                        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                            return
                        end
                        return {
                            timeout_ms = 2000,
                            lsp_fallback = true,
                        }
                    end,
                    formatters_by_ft = {
                        lua = { "stylua" },
                        typescript = { "prettierd" },
                        typescriptreact = { "prettierd" },
                        javascript = { "prettierd" },
                        javascriptreact = { "prettierd" },
                        ["htmlangular"] = { "prettierd" },
                        json = { "prettierd" },
                        html = { "prettierd" },
                        css = { "prettierd" },
                        scss = { "prettierd" },
                        -- go = { "gofmt" },
                        python = { "black" },
                    },
                }
            end,
        },
        {
            "chrisgrieser/nvim-scissors",
            dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
            opts = {
                snippetDir = vim.fn.stdpath "config" .. "/snippets",
            },
        },
        {
            "saghen/blink.cmp",
            version = "*",
            event = { "InsertEnter", "CmdlineEnter" },
            dependencies = {
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = { "rafamadriz/friendly-snippets" },
                    config = function()
                        require("luasnip").config.set_config { history = true, updateevents = "TextChanged,TextChangedI" }

                        -- vscode format
                        require("luasnip.loaders.from_vscode").lazy_load()
                        require("luasnip.loaders.from_vscode").lazy_load { paths = vim.fn.stdpath "config" .. "/snippets" }

                        -- -- snipmate format
                        -- require("luasnip.loaders.from_snipmate").load()
                        -- require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

                        -- -- lua format
                        -- require("luasnip.loaders.from_lua").load()
                        -- require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
                    end,
                },
                "rafamadriz/friendly-snippets",
            },
            opts = {
                snippets = { preset = "luasnip" },

                keymap = {
                    preset = "none",

                    ["<Tab>"] = { "show" },
                    ["<C-y>"] = { "select_and_accept" },
                    ["<C-k>"] = { "select_prev", "fallback" },
                    ["<C-j>"] = { "select_next", "fallback" },
                    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                },

                completion = {
                    documentation = { auto_show = true, auto_show_delay_ms = 500 },
                    menu = {
                        auto_show = function(ctx)
                            return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
                        end,
                    },
                },

                signature = { enabled = true },

                fuzzy = {
                    implementation = "prefer_rust",
                    sorts = {
                        function(a, b)
                            if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
                                return
                            end
                            return b.client_name == "emmet_ls"
                        end,
                        -- default sorts
                        "score",
                        "sort_text",
                    },
                },
                cmdline = {
                    completion = {
                        menu = { auto_show = true },
                    },
                    keymap = {
                        preset = "none",

                        ["<Tab>"] = { "show" },
                        ["<C-y>"] = { "select_and_accept" },
                        ["<C-k>"] = { "select_prev", "fallback" },
                        ["<C-j>"] = { "select_next", "fallback" },
                        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                    },
                },
            },
            opts_extend = { "sources.default" },
        },
        {
            "mattkubej/jest.nvim",
            keys = { "Jest", "JestFile", "JestSingle", "JestCoverage" },
            opts = {},
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            cmd = "Neotree",
            lazy = true,
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
            keys = {
                {
                    "<leader>e",
                    function()
                        require("neo-tree.command").execute { toggle = true, dir = vim.uv.cwd() }
                    end,
                    desc = "Explorer NeoTree (cwd)",
                },
            },
            opts = {},
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
        },
        { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    },
}
