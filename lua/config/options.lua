vim.g.mapleader = " "
vim.g.localleader = " "
vim.g.netrw_banner = 0

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.laststatus = 3
vim.opt.statusline = " %f %m%r%=%y %l:%c %p%% "
vim.opt.fillchars = { eob = " " }

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = false
if vim.fn.exists("&winborder") == 1 then
	vim.opt.winborder = "single"
end
vim.opt.breakindent = true

vim.cmd("syntax enable")

local terminal_mono = {
	gray = "ctermfg=8",
	accent = "ctermfg=3",

	code = {
		"Identifier", "Function", "Statement", "PreProc", "Type", "Special", "Keyword",
		"Conditional", "Repeat", "Label", "Exception", "Operator",
		"@variable", "@function", "@function.call", "@method", "@method.call", "@property", "@field",
		"@keyword", "@type", "@module", "@namespace", "@operator",
		"netrwSymLink",
		"GitSignsAdd", "GitSignsChange", "GitSignsUntracked",
		"GitSignsAddNr", "GitSignsChangeNr", "GitSignsUntrackedNr",
		"GitSignsAddLn", "GitSignsChangeLn", "GitSignsUntrackedLn",
	},

	noise = {
		"NormalFloat", "FloatBorder", "WinSeparator", "SignColumn", "FoldColumn", "LineNr",
		"NonText", "EndOfBuffer", "Whitespace", "Conceal", "Comment", "Delimiter", "Ignore",
		"ModeMsg", "Pmenu", "Directory", "MoreMsg", "Question", "QuickFixLine",
		"FloatShadow", "FloatShadowThrough",
		"TelescopeBorder", "TelescopePromptBorder", "TelescopeResultsBorder", "TelescopePreviewBorder",
		"TelescopePromptPrefix", "TelescopeSelectionCaret", "TelescopeTitle",
		"BlinkCmpMenu", "BlinkCmpMenuBorder", "BlinkCmpLabel", "BlinkCmpLabelDetail", "BlinkCmpLabelDescription",
		"BlinkCmpSource", "BlinkCmpKind", "BlinkCmpDoc", "BlinkCmpDocBorder", "BlinkCmpDocSeparator",
		"BlinkCmpSignatureHelp", "BlinkCmpSignatureHelpBorder",
		"WhichKey", "WhichKeyDesc", "WhichKeyGroup", "WhichKeyIcon", "WhichKeySeparator", "WhichKeyValue",
		"WhichKeyBorder", "WhichKeyNormal", "WhichKeyFloat",
		"netrwClassify", "netrwComment", "netrwHelpCmd", "netrwHide", "netrwLink", "netrwList",
		"@comment", "@punctuation", "@punctuation.delimiter", "@punctuation.bracket", "@tag.delimiter",
	},

	signal = {
		"String", "Character", "Constant", "Number", "Boolean", "Float",
		"Error", "ErrorMsg", "WarningMsg",
		"DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint", "DiagnosticOk",
		"DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint",
		"Added", "Changed", "Removed", "DiffAdd", "DiffChange", "DiffText", "DiffDelete",
		"GitSignsDelete", "GitSignsTopdelete", "GitSignsChangedelete",
		"GitSignsDeleteNr", "GitSignsTopdeleteNr", "GitSignsChangedeleteNr",
		"GitSignsDeleteLn", "GitSignsTopdeleteLn", "GitSignsChangedeleteLn",
		"netrwDir", "TelescopeMatching", "BlinkCmpLabelMatch",
		"NvimInternalError", "RedrawDebugClear", "RedrawDebugComposed", "RedrawDebugRecompose",
		"@string", "@character", "@constant", "@constant.builtin", "@number", "@boolean", "@float",
	},
}
vim.g.terminal_mono_palette = { gray = terminal_mono.gray, accent = terminal_mono.accent }

function terminal_mono.apply()
	vim.cmd("highlight clear")
	vim.g.colors_name = "terminal-mono"
	vim.o.background = "dark"

	local function set(groups, spec)
		for _, group in ipairs(groups) do
			vim.cmd(("highlight %s %s"):format(group, spec))
		end
	end

	vim.cmd("highlight Normal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE")
	vim.cmd("highlight NormalNC ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE")
	vim.cmd("highlight CursorLine cterm=NONE ctermbg=NONE gui=NONE guibg=NONE")

	set(terminal_mono.code, "ctermfg=NONE ctermbg=NONE cterm=NONE")
	set(terminal_mono.noise, terminal_mono.gray)
	set(terminal_mono.signal, terminal_mono.accent)
	set({ "Visual", "VisualNOS", "Search", "IncSearch", "CurSearch", "Substitute", "PmenuSel", "WildMenu", "BlinkCmpMenuSelection", "BlinkCmpDocCursorLine" }, "cterm=reverse")
	set({ "TelescopeSelection" }, "ctermfg=NONE ctermbg=NONE cterm=NONE")
	set({ "DiagnosticUnderlineError", "DiagnosticUnderlineWarn", "DiagnosticUnderlineInfo", "DiagnosticUnderlineHint" }, "cterm=underline")
	set({ "StatusLine", "StatusLineNC" }, terminal_mono.gray .. " ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE")

	vim.api.nvim_set_hl(0, "MatchParen", { bold = true, underline = true })
	vim.cmd("highlight PmenuThumb cterm=reverse")
	vim.cmd("highlight DiagnosticVirtualTextError " .. terminal_mono.accent)
end

_G.apply_terminal_mono = terminal_mono.apply
terminal_mono.apply()
