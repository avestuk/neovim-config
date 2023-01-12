local lspconfig = require "lspconfig"

local ok, nvim_status = pcall(require, "lsp-status")
if not ok then
  nvim_status = nil
end

local custom_attach = function(client, bufnr)
    local opts = { noremap=true, silent=true }
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
    buf_set_keymap('n', ']d', '<cmd>lua vim..diagnostic.goto_next()<CR>', opts)
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
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      buildFlags = {"-tags=e2e integration"}
    },
  },
  capabilities = capabilities,
  on_attach = custom_attach,
}

function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = {only = {"source.organizeImports"}}
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

-- For servers that don't need any config
local servers = {"bashls", "terraformls", "rust_analyzer", "pyright"}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
            capabilities = capabilities, 
            on_attach = custom_attach,
        }
end

