-- NOTE: nixCats: might want to move the lazy-lock.json file
local function getlockfilepath()
	if require("nixCatsUtils").isNixCats and type(nixCats.settings.unwrappedCfgPath) == "string" then
		return nixCats.settings.unwrappedCfgPath .. "/lazy-lock.json"
	else
		return vim.fn.stdpath("config") .. "/lazy-lock.json"
	end
end

local lazyOptions = {
	lockfile = getlockfilepath(),
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}

-- NOTE: Here is where you install your plugins.
-- NOTE: nixCats: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require("nixCatsUtils.lazyCat").setup(nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }), {
	-- load plugins here

	-- NOTE: Themes
	-- Choose theme by using the config option.

	-- [ "tokyonight", "tokyonight-day", "tokyonight-storm", "tokyonight-moon", "tokyonight-night" ]
	{
		"folke/tokyonight.nvim",
		opts = {
			on_colors = function(colors)
				colors.bg = "#000000"
				colors.bg_dark = "#000000"
				colors.bg_float = "#000000"
				colors.bg_sidebar = "#000000"
				colors.bg_statusline = "#000000"
			end,
		},
	},
	-- [ "catppuccin", "catppuccin-latte", "catppuccin-frappe", "catppuccin-macchiato", "catppuccin-mocha" ]
	{
		"catppuccin/nvim",
		name = "catppuccin.nvim",
		opts = {
			term_colors = true,
			default_integrations = true,
			color_overrides = {
				mocha = { base = "#000000", mantle = "#000000", crust = "#000000" },
				frappe = { base = "#000000", mantle = "#000000", crust = "#000000" },
				macchiato = { base = "#000000", mantle = "#000000", crust = "#000000" },
				latte = { base = "#000000", mantle = "#000000", crust = "#000000" },
			},
		},
	},
	-- [ "gruvbox-material" ]
	{ "sainnhe/gruvbox-material" },
	-- [ "rose-pine", "rose-pine-main", "rose-pine-moon", "rose-pine-dawn" ]
	{ "rose-pine/neovim", name = "rose-pine.nvim", opts = { styles = { transparency = true } } },

	-- NOTE: load mini-icons including nvim-dev-icons
	{ import = "config.plugins.mini-icons" },

	-- NOTE: animate cursor
	{ import = "config.plugins.smear-cursor" },

	-- NOTE: Which Keys
	{ import = "config.plugins.which-keys" },

	-- NOTE: Todo Comments
	{ import = "config.plugins.todo-comments" },

	-- NOTE: better diagnostics list and others
	{ import = "config.plugins.trouble" },

	-- NOTE: Git Signs
	{ import = "config.plugins.git-signs" },

	-- NOTE: Lualine
	{ import = "config.plugins.lualine" },

	-- NOTE: Folke Snacks
	{ import = "config.plugins.snacks" },

	-- NOTE: better comments
	{ import = "config.plugins.ts-comments" },

	-- NOTE: Fuzzy Finder (files, lsp, etc) Telescope
	{ import = "config.plugins.telescope" },

	-- NOTE: Markdown preview
	{ import = "config.plugins.render-markdown" },

	-- NOTE: Highlight, edit, and navigate code
	{ import = "config.plugins.treesitter" },

	-- NOTE: Mini Pairs
	{ import = "config.plugins.mini-pairs" },

	-- NOTE: properly configures LuaLS for editing your Neovim config
	{ import = "config.plugins.lazydev" },

	-- NOTE: autocomplete via blink.cmp
	{ import = "config.plugins.blink-cmp" },

	-- NOTE: conform formatter
	{ import = "config.plugins.conform" },
}, lazyOptions)

vim.cmd.colorscheme("catppuccin")
