return {
	"stevearc/conform.nvim",
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_format = "fallback", timeout_ms = 3000 })
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
	},
	opts = {
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			nix = { "alejandra" },
			sh = { "shfmt" },
			python = { "ruff" },
			rust = { "rustfmt", lsp_format = "fallback" },
			svelte = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescriptreact = { "prettierd" },
			css = { "prettierd" },
			html = { "prettierd" },
			json = { "prettierd" },
			c = { "clang-format" },
			cpp = { "clang-format" },
		},
	},
}
