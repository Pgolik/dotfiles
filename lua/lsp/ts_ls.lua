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
}
