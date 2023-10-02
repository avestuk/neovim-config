local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
	keys = {
		{ "<F5>",       "<cmd> DapContinue<CR>" },
		{ "<F3>",       "<cmd> DapStepOver<CR>" },
		{ "<F2>",       "<cmd> DapStepInto<CR>" },
		{ "<F12>",      "<cmd> DapStepOut<CR>" },
		{ "<leader>b",  "<cmd> DapToggleBreakpoint<CR>" },
		{ "<leader>B",  "<cmd> require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
		{ "<leader>lp", "<cmd> require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
		{ "<leader>dr", "<cmd> DapToggleRepl<CR>" },
		{ "<leader>dt", "<cmd> require'dap-go'.debug_test()<CR>" },
	},
}

return M
