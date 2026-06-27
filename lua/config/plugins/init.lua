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
}

require("nixCatsUtils.lazyCat").setup(nixCats.pawsible({ "allPlugins", "start", "lazy.nvim" }), {
	{ import = "config.plugins.git-signs" },
	{ import = "config.plugins.which-keys" },
	{ import = "config.plugins.telescope" },
	{ import = "config.plugins.treesitter" },
	{ import = "config.plugins.blink-cmp" },
	{ import = "config.plugins.conform" },
}, lazyOptions)

_G.apply_terminal_mono()
