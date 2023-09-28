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
		{"n", "<F5>", "<cmd> DapContinue<CR>"},
		{"n", "<F3>", "<cmd> DapStepOver<CR>"},
		{"n", "<F2>", "<cmd> DapStepInto<CR>"},
		{"n", "<F12>", "<cmd> DapStepOut<CR>"},
		{"n", "<leader>b", "<cmd> DapToggleBreakpoint<CR>"},
		{"n", "<leader>B", "<cmd> require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"},
		{"n", "<leader>lp", "<cmd> require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"},
		{"n", "<leader>dr", "<cmd> DapToggleRepl<CR>"},
		{"n", "<leader>dt", "<cmd> require'dap-go'.debug_test()<CR>"},
	},
    }

return M
