-- Scheme/Lisp editing support
return {
  -- Parinfer: structural editing (auto-balances parens)
  {
    "gpanders/nvim-parinfer",
    ft = { "scheme", "lisp", "clojure", "fennel", "racket" },
    opts = {
      mode = "smart", -- "indent" | "paren" | "smart"
    },
  },
}
