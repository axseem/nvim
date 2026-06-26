local servers = {
	marksman = { cmd = { "marksman", "server" }, filetypes = { "markdown", "markdown.mdx" }, root_markers = { ".marksman.toml", ".git" } },
	nixd = { cmd = { "nixd" }, filetypes = { "nix" }, root_markers = { "flake.nix", ".git" } },
	lua_ls = { cmd = { "lua-language-server" }, filetypes = { "lua" }, root_markers = { ".luarc.json", ".luarc.jsonc", ".git" } },
	basedpyright = { cmd = { "basedpyright-langserver", "--stdio" }, filetypes = { "python" }, root_markers = { "pyproject.toml", "setup.py", ".git" } },
	clangd = { cmd = { "clangd" }, filetypes = { "c", "cpp" }, root_markers = { ".clangd", "compile_commands.json", "CMakeLists.txt", ".git" } },
	["rust-analyzer"] = { cmd = { "rust-analyzer" }, filetypes = { "rust" }, root_markers = { "Cargo.toml", "rust-project.json", ".git" } },
	ts_ls = { cmd = { "typescript-language-server", "--stdio" }, filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" }, root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" } },
	svelte = { cmd = { "svelteserver", "--stdio" }, filetypes = { "svelte" }, root_markers = { "package.json", ".git" } },
	eslint = { cmd = { "vscode-eslint-language-server", "--stdio" }, filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" }, root_markers = { "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", ".eslintrc", ".eslintrc.json", "package.json" } },
	zls = { cmd = { "zls" }, filetypes = { "zig", "zir" }, root_markers = { "zls.json", "build.zig", ".git" } },
}

for name, config in pairs(servers) do
	if vim.fn.executable(config.cmd[1]) == 1 then
		vim.lsp.config(name, config)
		vim.lsp.enable(name)
	end
end

vim.lsp.inlay_hint.enable(false)

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(mode, keys, func, desc)
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
		end

		map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "gI", vim.lsp.buf.implementation, "Goto Implementation")
		map("n", "gy", vim.lsp.buf.type_definition, "Goto Type Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
		map("i", "<c-k>", vim.lsp.buf.signature_help, "Signature Help")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, "Code Lens")
		map("n", "<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Code Lens")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
	end,
})
