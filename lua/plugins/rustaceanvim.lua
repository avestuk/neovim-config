local M = {
	'mrcjkb/rustaceanvim',
	version = '^4', -- Recommended
	lazy = false, -- This plugin is already lazy
	default_settings = {
		-- rust-analyzer language server configuration
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = {
					enable = true,
				},
			},
			-- Add clippy lints for Rust.
			checkOnSave = true,
			procMacro = {
				enable = true,
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
			},
		}
	}
}

return M
