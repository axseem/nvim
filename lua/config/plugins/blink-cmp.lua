return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	opts = function()
		local snippet_dir = require("nixCatsUtils").isNixCats and require("nixCats").configDir .. "/snippets"
			or vim.fn.stdpath("config") .. "/snippets"

		return {
			keymap = { preset = "super-tab" },
			appearance = { nerd_font_variant = "mono" },
			completion = {
				documentation = { auto_show = false },
				ghost_text = { enabled = false },
			},
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					snippets = {
						opts = {
							search_paths = { snippet_dir },
						},
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		}
	end,
}
