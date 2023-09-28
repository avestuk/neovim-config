local M = {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "macchiato", -- latte, frappe, mocha
	},
	config = function()
		local catpuccin = require("catppuccin")
		catpuccin.setup(opts)
		catpuccin.load()
	end,
}

return M
