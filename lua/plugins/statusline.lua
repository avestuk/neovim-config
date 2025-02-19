local M = {
	'echasnovski/mini.statusline',
	version = '*',
	lazy = false,
	config = function()
		require('mini.statusline').setup()
	end
}

return M
