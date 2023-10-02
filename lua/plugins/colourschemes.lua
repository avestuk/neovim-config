local M = {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "macchiato", -- latte, frappe, mocha
		integrations = {
			treesitter = true,
			mason = true,
			cmp = true,
			dap = {
				enabled = true,
				enable_ui = true,
			},
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			telescope = {
				enabled = true
			},
		}
	},
	config = function()
		local catpuccin = require("catppuccin")
		catpuccin.setup(opts)
		catpuccin.load()
	end,
}

return M
