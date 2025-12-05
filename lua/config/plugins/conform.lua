if nixCats("formatters") then
	return {
		"stevearc/conform.nvim",
		lazy = false,
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				sh = { "shfmt" },
				python = { "ruff" },
				rust = { "rustfmt", lsp_format = "fallback" },
				svelte = { "eslint_d" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
			},
			formatters = {
				eslint_d = {
					condition = function(self, ctx)
						return vim.fs.find({
							".eslintrc.js",
							".eslintrc.cjs",
							".eslintrc.yaml",
							".eslintrc.yml",
							".eslintrc.json",
							"eslint.config.js",
						}, { path = ctx.filename, upward = true })[1]
					end,
				},
			},
		},
	}
else
	return {}
end
