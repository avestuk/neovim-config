-- Setup Mason
require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require "lspconfig"

local ok, nvim_status = pcall(require, "lsp-status")
if not ok then
    nvim_status = nil
end

local custom_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
--
-- better autocompletion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
    -- Format the autocomplete menu
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
        })
    },
    mapping = {
        -- Use Tab and shift-Tab to navigate autocomplete menu
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end,
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'buffer' },
        { name = 'luasnip' },
    },
}

-- some shorthands...
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node

local date = function()
    return { os.date "%Y-%m-%d" }
end

local filename = function()
    return { vim.fn.expand "%:p" }
end

luasnip.config.set_config {
    history = true,
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 200,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = false,
    store_selection_keys = "<c-s>",
}

luasnip.add_snippets(nil, {
    all = {
        snip({
            trig = "date",
            namr = "Date",
            dscr = "Date in the form of YYYY-MM-DD",
        }, {
            func(date, {}),
        }),
        snip({
            trig = "filename",
            namr = "Filename",
            dscr = "Absolute path to file",
        }, {
            func(filename, {}),
        }),
    },
    sh = {
        snip("shebang", {
            text { "#!/bin/sh", "" },
            insert(0),
        }),
    },
    python = {
        snip("shebang", {
            text { "#!/usr/bin/env python", "" },
            insert(0),
        }),
    },
    lua = {
        snip("shebang", {
            text { "#!/usr/bin/lua", "", "" },
            insert(0),
        }),
        snip("req", {
            text "require('",
            insert(1, "Module-name"),
            text "')",
            insert(0),
        }),
        snip("func", {
            text "function(",
            insert(1, "Arguments"),
            text { ")", "\t" },
            insert(2),
            text { "", "end", "" },
            insert(0),
        }),
        snip("forp", {
            text "for ",
            insert(1, "k"),
            text ", ",
            insert(2, "v"),
            text " in pairs(",
            insert(3, "table"),
            text { ") do", "\t" },
            insert(4),
            text { "", "end", "" },
            insert(0),
        }),
        snip("fori", {
            text "for ",
            insert(1, "k"),
            text ", ",
            insert(2, "v"),
            text " in ipairs(",
            insert(3, "table"),
            text { ") do", "\t" },
            insert(4),
            text { "", "end", "" },
            insert(0),
        }),
        snip("if", {
            text "if ",
            insert(1),
            text { " then", "\t" },
            insert(2),
            text { "", "end", "" },
            insert(0),
        }),
        snip("M", {
            text { "local M = {}", "", "" },
            insert(0),
            text { "", "", "return M" },
        }),
    },
    go = {
        snip("test", {
            text "func ",
            insert(1, "Name"),
            text "(t *testing.T)",
            text { " {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),
        snip("typei", {
            text "type ",
            insert(1, "Name"),
            text { " interface {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),
        snip("types", {
            text "type ",
            insert(1, "Name"),
            text { " struct {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),
        snip("func", {
            text "func ",
            insert(1, "Name"),
            text "(",
            insert(2),
            text ")",
            insert(3),
            text { " {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),
        snip("if", {
            text "if ",
            insert(1, "true"),
            text { " {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),

        snip("fori", {
            text "for ",
            insert(1, "i := 0"),
            text ";",
            insert(2, "i < 10"),
            text ";",
            insert(3, "i++"),
            text { " {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),
        snip("forr", {
            text "for ",
            insert(1, "k, v"),
            text " := range ",
            insert(2, "expr"),
            text { " {", "" },
            text "\t",
            insert(0),
            text { "", "}" },
        }),
    },
})

-- Autopairs
local autopairs = require("nvim-autopairs")
autopairs.setup({
    check_ts = true,
})
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done { map_char = { tex = "" } }
)

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- GoPls
util = require "lspconfig/util"
lspconfig.gopls.setup {
    cmd = { "gopls", "serve" },
    filetypes = { "go", "gomod" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            buildFlags = { "-tags=e2e integration" }
        },
    },
    capabilities = capabilities,
    on_attach = custom_attach,
}

function go_org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
end

-- Rust
local extension_path = '/Users/alexander.vest/.local/share/nvim/mason/packages/codelldb/extension/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local opts = {
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=>",
        },
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = custom_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}

require("rust-tools").setup(opts)
require('rust-tools').runnables.runnables()

--lspconfig.rust_analyzer.setup {
--    capabilities = capabilities,
--    on_attach = custom_attach,
--    settings = {
--        ["rust-analyzer"] = {
--            checkOnSave = {
--                command = "clippy",
--            },
--            inlayHints = {
--                lifetimeElisionHints = {
--                    enable = true,
--                    useParameterNames = true
--                },
--            },
--        },
--    },
--    cmd = {
--        "rustup", "run", "stable", "rust-analyzer",
--    }
--}

-- Snyk

-- vim.lsp.set_log_level 'trace'
-- if vim.fn.has 'nvim-0.5.1' == 1 then
--     require('vim.lsp.log').set_format_func(vim.inspect)
-- end
--
-- lspconfig.configs.snyk = {
--     configs.snyk = {
--        default_config = {
--           cmd = {'/usr/local/bin/snyk-ls','-f','/Users/alexander.vest/.cache/nvim/lsp.log'},
--           root_dir = function(name)
--               return lspconfig.util.find_git_ancestor(name) or vim.loop.os_homedir()
--           end,
--           init_options = {
--               activateSnykCode = "true",
--           }
--        }
--     }
-- }


-- JSON
local capabilities_json = capabilities
capabilities_json.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'.jsonls.setup {
    capabilities = capabilities_json,
    on_attach = custom_attach,
}

-- For servers that don't need any config
local servers = { "bashls", "pyright", "lua_ls", "terraformls"}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
        on_attach = custom_attach,
    }
end


