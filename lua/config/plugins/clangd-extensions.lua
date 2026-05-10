-- Clangd extensions: AST, type hierarchy, switch source/header, memory usage
return {
	{
		"p00f/clangd_extensions.nvim",
		ft = { "c", "cpp" },
		opts = {
			extensions = {
				inlay_hints = {
					inline = false, -- use Neovim's native inlay hints instead
				},
				ast = {
					-- defaults are fine
				},
				memory_usage = {
					border = "rounded",
				},
				symbol_info = {
					border = "rounded",
				},
			},
		},
		keys = {
			{ "<leader>cA", "<cmd>ClangdAST<cr>", desc = "Clangd AST", ft = { "c", "cpp" } },
			{ "<leader>cH", "<cmd>ClangdTypeHierarchy<cr>", desc = "Clangd Type Hierarchy", ft = { "c", "cpp" } },
			{ "<leader>cM", "<cmd>ClangdMemoryUsage<cr>", desc = "Clangd Memory Usage", ft = { "c", "cpp" } },
			{ "<leader>cS", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header", ft = { "c", "cpp" } },
		},
	},
}
