local M = {
	"ThePrimeagen/harpoon",
	event = "BufReadPre",
	keys = {

		{ "<leader>hx", function() require("harpoon.mark").add_file() end, desc = "Harpoon mark" },
		{ "<leader>hn", function() require("harpoon.ui").nav_next() end,   desc = "Harpoon next" },
		{ "<leader>hp", function() require("harpoon.ui").nav_prev() end,   desc = "Harpoon prev" },
	},
	opts = {
		global_settings = {
			-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
			save_on_toggle = false,

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
	config = function(_, opts)
		require("harpoon").setup(opts.global_settings)
		local telescope = require("telescope")
		telescope.load_extension("harpoon")
	end,
}

return M
