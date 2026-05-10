---@brief
--- https://clangd.llvm.org/
---
--- C/C++ language server (part of clang-tools)

vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp' },
  root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', 'CMakeLists.txt', '.git' },
})
