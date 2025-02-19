-- Load vim options
require("config.options")

--Load keybinds
require("config.keybinds")

-- Load plugins
require("config.lazy")

-- Load autocmds
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("config.autocmds")
	end,
})
