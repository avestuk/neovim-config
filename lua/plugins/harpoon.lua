local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	opts = {
		global_settings = {
			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
			save_on_toggle = true,

			-- saves the harpoon file upon every change. disabling is unrecommended.
			save_on_change = true,

			-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
			enter_on_sendcmd = false,

			-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
			tmux_autoclose_windows = false,

			-- filetypes that you want to prevent from adding to the harpoon list menu.
			excluded_filetypes = { "harpoon" },

			-- set marks specific to each git branch inside git repository
			mark_branch = false,

			-- enable tabline with harpoon marks
			tabline = false,
			tabline_prefix = "   ",
			tabline_suffix = "   ",
		}
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local function map(lhs, rhs, opts)
			vim.keymap.set("n", lhs, rhs, opts or {})
		end

		map("<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
		map("<leader>a", function() harpoon:list():append() end)
		map("<leader>1", function() harpoon:list():select(1) end)
		map("<leader>2", function() harpoon:list():select(2) end)
		map("<leader>3", function() harpoon:list():select(3) end)
		map("<leader>4", function() harpoon:list():select(4) end)
		map("<leader>dh", function() harpoon:list():clear() end)
	end,
}

return M
