local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function(_, opts)
				require("dapui").setup(opts)
			end,
			keys = {
				{ "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
			}
		},
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
		{
			"leoluz/nvim-dap-go",
			opts = {},
			keys = {
				{ "<leader>dt", function() require 'dap-go'.debug_test() end },
			},
		},
	},
	keys = {
		{
			"<F5>",
			function() require("dap").continue() end,
			desc = "Continue",
		},
		{
			"<F3>",
			function() require("dap").step_over() end,
			desc = "Step Over",
		},
		{
			"<F2>",
			function() require("dap").step_into() end,
			desc = "Step Over",
		},
		{
			"<F12>",
			function() require("dap").step_out() end,
			desc = "Step Out"
		},
		{
			"<leader>b",
			function() require("dap").toggle_breakpoint() end,
			desc = "Toggle Breakpoint"
		},
		{
			"<leader>B",
			function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
			desc = "Breakpoint Condition"
		},
	},

}

function M.config()
	local dap = require("dap")
	local dapui = require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

return M
