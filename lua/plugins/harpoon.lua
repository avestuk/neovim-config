local M = {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim"
	},
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
			mark_branch = true,

			-- enable tabline with harpoon marks
			tabline = false,
			tabline_prefix = "   ",
			tabline_suffix = "   ",
		}
	},
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end

		vim.keymap.set("n", "<leader>h", function() toggle_telescope(harpoon:list()) end,
			{ desc = "Open harpoon window" })
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add harpoon entry" })
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,
			{ desc = "Jump to harpoon 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,
			{ desc = "Jump to harpoon 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,
			{ desc = "Jump to harpoon 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,
			{ desc = "Jump to harpoon 3" })
		vim.keymap.set("n", "<leader>dh", function() harpoon:list():clear() end, { desc = "Clear harpoon marks" })
	end,
}

return M
