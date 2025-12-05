---@brief
---
--- https://github.com/sveltejs/language-tools/tree/master/packages/language-server
---
--- `svelte-language-server` is a language server for Svelte.
---
--- Install via npm:
--- ```sh
--- npm install -g svelte-language-server
--- ```

vim.lsp.config("svelte", {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = { "package.json", ".git" },
})
