local M = {
	"L3MON4D3/LuaSnip",
	version = "2.2.0",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	event = "InsertEnter",
	build = "Make install_jsregexp",
	config = function(_, opts)
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		--vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })

		-- Load friendly snippets
		require("luasnip.loaders.from_vscode").lazy_load()
		-- Load Custom snippets
		require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/lua/snippets/" })
	end
}

return M
