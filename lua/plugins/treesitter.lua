local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		ensure_installed = {
			"bash",
			"dockerfile",
			"go",
			"json",
			"lua",
			"markdown",
			"python",
			"rust",
			"yaml",
		},
		highlight = {
			enable = true,
			-- Required for catpuccin
			additional_vim_regex_highlighting = false,
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 * 1024 -- 100 MB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = 'ga',
				node_incremental = 'ga',
				node_decremental = 'gz',
			},
		},
		sync_install = true,
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
					['ia'] = '@parameter.inner',
				}
			},
			swap = {
				enable = true,
				swap_previous = {
					['{a'] = '@parameter.inner',
				},
				swap_next = {
					['}a'] = '@parameter.inner',
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					[']f'] = '@function.outer',
					[']c'] = '@class.outer',
					[']a'] = '@parameter.inner',
				},
				goto_next_end = {
					[']F'] = '@function.outer',
					[']C'] = '@class.outer',
				},
				goto_previous_start = {
					['[f'] = '@function.outer',
					['[c'] = '@class.outer',
					['[a'] = '@parameter.inner',
				},
				goto_previous_end = {
					['[F'] = '@function.outer',
					['[C'] = '@class.outer',
				},
			},
		},
		refactor = {
			highlight_definitions = {
				enable = true,
				-- Set to false if you have an `updatetime` of ~100.
				clear_on_cursor_move = true,
			},
			highlight_current_scope = { enable = false },
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}

return M
