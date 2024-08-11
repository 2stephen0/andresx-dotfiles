return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-python",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({
						dap = {
							justMyCode = false,
							console = "integratedTerminal",
						},
						args = { "--log-level", "DEBUG", "--quiet" },
						runner = "pytest",
					}),
				},
			})
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = {
					"folke/neodev.nvim",
					"nvim-neotest/nvim-nio",
				},
				config = function()
					require("neodev").setup({
						library = { plugins = { "nvim-dap-ui" }, types = true },
					})
				end,
			},
			"nvim-neotest/nvim-nio",
			"pocco81/dap-buddy.nvim",
			{
				"mfussenegger/nvim-dap-python",
				filetype = "python",
				config = function()
					local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
					-- local path = '~/.virtualenvs/debugpy/bin/python'
					require("dap-python").setup(path)
				end,
			},
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			local dapPython = require("dap-python")

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", dap.continue, {})
			vim.keymap.set("n", "<leader>dm", dapPython.test_method, {})
		end,
	},
}
