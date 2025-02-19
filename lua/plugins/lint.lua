local M = {
	"mfussenegger/nvim-lint",
	event = "BufEnter",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			go = { "golangcilint" },
			--markdown = { "markdownlint" },
			sql = { "sqlfluff" },
			terraform = { "tflint" },
			yaml = { "yamllint" },
		}

		local linters = require("lint").linters
		-- Returns the default path for the neovim config dir
		local linterConfig = vim.fn.stdpath("config") .. '.linter_configs'

		linters.yamllint.args = {
			"--config-file",
			linterConfig .. "/yamllint.yaml",
			"--format=parsable",
			"-",
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
				local bufnr = vim.api.nvim_get_current_buf()

				-- Get the full path of the current buffer
				local bufname = vim.api.nvim_buf_get_name(bufnr)

				-- Check if the buffer name contains ".github"
				--if bufname:find("%.github") then
				--	lint.try_lint("actionlint")
				--end
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint("actionlint")
		end, { desc = "Trigger linting for current file" })
	end
}

return M
