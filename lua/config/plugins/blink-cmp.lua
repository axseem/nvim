return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  opts = {
    keymap = { preset = "super-tab" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      documentation = { auto_show = false },
      ghost_text = { enabled = false },
    },
    signature = { enabled = true },
    sources = {
      default = { "lsp", "path", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
