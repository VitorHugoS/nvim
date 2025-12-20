return {
	{
		"mason-org/mason.nvim",
		config = function()
			-- setup mason with default properties
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				ts_ls = {},
				html = {},
				jsonls = {},
				pylsp = {},
				eslint = {},
				jdtls = {},
				markdown_oxide = {},
				clojure_lsp = {
					init_options = {
						["additional-snippets"] = {},
						["document-formatting"] = true,
						["document-range-formatting"] = true,
					},
				},
			}
			require("mason-lspconfig").setup({
				ensure_installed = vim.tbl_keys(servers),
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			-- ensure the java debug adapter is installed
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test" },
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				ts_ls = {},
				html = {},
				jsonls = {},
				pylsp = {},
				eslint = {},
				--        jdtls = {},
				markdown_oxide = {},
				clojure_lsp = {
					init_options = {
						["additional-snippets"] = {},
						["document-formatting"] = true,
						["document-range-formatting"] = true,
					},
				},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
			capabilities.textDocument.hover = {
				contentFormat = { "markdown", "plaintext" },
			}
			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				vim.lsp.config(server, opts) -- configure the server
				vim.lsp.enable(server) -- enable it globally
			end
			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
			})
			-- basic keymaps
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, { desc = "Format buffer (LSP)" })
		end,
	},
}
