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
				menu = {
					draw = {
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
								highlight = function(ctx)
									if require("blink.cmp.completion.list").selected_item_idx == ctx.idx then
										return nil
									end
									return "BlinkCmpKind"
								end,
							},
							label = {
								width = { fill = true, max = 60 },
								text = function(ctx) return ctx.label .. ctx.label_detail end,
								highlight = function(ctx)
									local label = ctx.label
									local selected = require("blink.cmp.completion.list").selected_item_idx == ctx.idx
									local highlights = {}

									if not selected then
										table.insert(highlights, { 0, #label, group = "BlinkCmpLabel" })
										if ctx.label_detail then
											table.insert(highlights, { #label, #label + #ctx.label_detail, group = "BlinkCmpLabelDetail" })
										end
									end

									for _, idx in ipairs(ctx.label_matched_indices) do
										table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
									end

									return highlights
								end,
							},
							label_description = {
								width = { max = 30 },
								text = function(ctx) return ctx.label_description end,
								highlight = function(ctx)
									if require("blink.cmp.completion.list").selected_item_idx == ctx.idx then
										return nil
									end
									return "BlinkCmpLabelDescription"
								end,
							},
						},
					},
				},
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
