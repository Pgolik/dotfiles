vim.lsp.enable('vtsls')
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = '/usr/local/bin/vue-language-server',
  languages = { 'vue' },
  configNamespace = 'typescript',
}
vim.lsp.config['vtsls'] = {
  settings = {
    javascript = {
      suggest = { completeFunctionCalls = true },
      format = { semicolons = 'remove' },
      preferences = {
        quoteStyle = 'double',
        importModuleSpecifier = 'non-relative',
        includePackageJsonAutoImports = 'on'
      }
    },
    typescript = {
      format = {
        placeOpenBraceOnNewLineForControlBlocks = true,
        semicolons = 'remove'
      },
      suggest = { completeFunctionCalls = true },
      preferences = {
        quoteStyle = 'double',
        importModuleSpecifier = 'non-relative',
        includePackageJsonAutoImports = 'on',
        preferTypeOnlyAutoImports = true
      }
    },
    vtsls = {
      typescript = {
        format = {
          indentStyle = 2,
          trimTrailingWhitespace = true,
          convertTabsToSpaces = true,
          baseIndentSize = 0,
          indentSize = 2,
          tabSize = 0
        },
      },
      experimental = { completion = { enableServerSideFuzzyMatch = true, entriesLimit = 100 } },
      tsserver = {
        globalPlugins = {
          vue_plugin,
        }
      }
    },
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
  on_attach = function(client, bufnr)
    -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
    -- `vim.lsp.buf.code_action()` if specified in `context.only`.
    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptCustomAction', function()
      local custom_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.') or vim.startswith(action, 'refactor.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)
      vim.lsp.buf.code_action({
        context = {
          only = custom_actions,
          diagnostics = {},
        },
      })
    end, {})
    vim.keymap.set({ 'n', 'x' }, '<leader>ca', ':LspTypescriptCustomAction<CR>',
      { buffer = bufnr, desc = 'LSP: [C]ode [A]ctions', remap = false })
  end
}
