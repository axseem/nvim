return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				pcall(vim.treesitter.start)
			end,
		})
	end,
}
