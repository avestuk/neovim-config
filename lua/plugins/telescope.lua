local M = {
	'nvim-telescope/telescope.nvim', tag = '0.1.3',
	event = "BufReadPre",
	dependencies = {
	      {"nvim-lua/plenary.nvim"},
	      {"nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	      { "nvim-telescope/telescope-ui-select.nvim" },
      	},
      	keys = {
		{ "<leader>fF", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
		{ "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<cr>" },
		{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
		{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>" },
		{ "<leader>fd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>" },
	},
	opts = function()
		local actions = require("telescope.actions")
		local theme = require("telescope.themes")
		return {
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					additional_args = function(opts)
						return { "--hidden" }
					end,
				},
			},
			defaults = {
				mappings = { i = { ["<esc>"] = actions.close } },
			},

			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
				["ui-select"] = {
					theme.get_dropdown({}),
				},
			},
		}
	end,
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
	end,
    }

return M
