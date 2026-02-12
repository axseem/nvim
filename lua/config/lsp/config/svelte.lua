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
---
--- Full JS/TS support (find references, rename across .svelte files) requires
--- per-project `typescript-svelte-plugin` — see ts_ls config.

vim.lsp.config("svelte", {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = {
    "package-lock.json",
    "yarn.lock",
    "pnpm-lock.yaml",
    "bun.lockb",
    "bun.lock",
    "package.json",
    ".git",
  },
  on_attach = function(client, bufnr)
    -- Notify Svelte LSP when TS/JS files change so it picks up updated types
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
      callback = function(ctx)
        client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      end,
    })

    -- Command to migrate a Svelte component to Svelte 5 syntax
    vim.api.nvim_buf_create_user_command(bufnr, "LspMigrateToSvelte5", function()
      client:exec_cmd({
        command = "migrate_to_svelte_5",
        arguments = { vim.uri_from_bufnr(bufnr) },
      })
    end, {})
  end,
})
