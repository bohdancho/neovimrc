local capabilities =
    vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), require("cmp_nvim_lsp").default_capabilities())

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf

        -- was necessary with none_ls (i think to prefer dedicated formatters to lsp formatting), idk if i need it with conform
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- client.server_capabilities.documentFormattingProvider = false
        -- client.server_capabilities.documentRangeFormattingProvider = false

        require("lsp_signature").on_attach({}, bufnr)

        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
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
    end,
})

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "yioneko/nvim-vtsls",
        "nvim-lua/plenary.nvim", -- used for bohdancho.renamer
        "ray-x/lsp_signature.nvim",
    },
    config = function()
        -- set default server config, optional but recommended
        require("lspconfig.configs").vtsls = require("vtsls").lspconfig

        local servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            -- Tells lua_ls where to find all the Lua files that you have loaded
                            -- for your neovim configuration.
                            library = {
                                "${3rd}/luv/library",
                                unpack(vim.api.nvim_get_runtime_file("", true)),
                            },
                            -- If lua_ls is really slow on your computer, you can try this instead:
                            -- library = { vim.env.VIMRUNTIME },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
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
                            require("luasnip").lsp_expand(snip_string)
                        end, bufnr)
                    end)
                end,
            },
            tailwindcss = {
                settings = {
                    -- add autocomplete in unusual places for classes like cva
                    tailwindCSS = { experimental = { classRegex = { { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" } } } },
                },
            },
            angularls = {},
            gopls = {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            unreachable = true,
                        },
                        staticcheck = true,
                    },
                },
            },
        }

        local ensure_installed = vim.tbl_keys(servers)
        require("mason-lspconfig").setup { ensure_installed = ensure_installed }

        for server_name, server in pairs(servers) do
            server.capabilities = vim.tbl_deep_extend("force", capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
        end

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
}
