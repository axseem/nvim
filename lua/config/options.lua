vim.g.mapleader = " "
vim.g.localleader = " "
vim.g.netrw_banner = 0

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.grepprg = "rg --vimgrep --smart-case --hidden"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.confirm = true
vim.opt.laststatus = 3
vim.opt.statusline = " %f %m%r%=%y %l:%c %p%% "
vim.opt.fillchars = { eob = " " }

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.undofile = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 20
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = false
if vim.fn.exists("&winborder") == 1 then
	vim.opt.winborder = "single"
end
vim.opt.breakindent = true

vim.cmd("syntax enable")

local terminal_mono = {
	foreground = "ctermfg=NONE",
	background = "ctermbg=NONE",
	gray = "ctermfg=8 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE",
	accent = "ctermfg=3 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE",
	selection = "ctermfg=NONE ctermbg=NONE cterm=reverse guifg=NONE guibg=NONE gui=reverse",

	-- Keep the theme to four terminal colors at any time: background, foreground, gray, and accent.
	-- Every syntax group must be set explicitly so Vim defaults do not leak extra colors.
	code = {
		"Identifier", "Function",
		"String", "Character", "Constant", "Number", "Boolean", "Float",
		"@variable", "@function", "@function.call", "@method", "@method.call", "@property", "@field",
		"@module", "@namespace",
		"@string", "@character", "@constant", "@constant.builtin", "@number", "@boolean", "@float",
		"netrwSymLink",
		"GitSignsAdd", "GitSignsChange", "GitSignsUntracked",
		"GitSignsAddNr", "GitSignsChangeNr", "GitSignsUntrackedNr",
		"GitSignsAddLn", "GitSignsChangeLn", "GitSignsUntrackedLn",
	},

	keywords = {
		"Statement", "PreProc", "Type", "Special",
		"Keyword", "Conditional", "Repeat", "Label", "Exception", "Operator",
		"@keyword", "@operator", "@type", "@type.builtin",
	},

	noise = {
		"NormalFloat", "FloatBorder", "WinSeparator", "SignColumn", "FoldColumn", "LineNr",
		"NonText", "EndOfBuffer", "Whitespace", "Conceal", "Comment", "Delimiter", "Ignore",
		"SpecialKey", "Folded", "ColorColumn", "CursorColumn", "WinBar", "WinBarNC",
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
		"Error", "ErrorMsg", "WarningMsg",
		"Title", "Todo",
		"DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint", "DiagnosticOk",
		"DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint",
		"Added", "Changed", "Removed", "DiffAdd", "DiffChange", "DiffText", "DiffDelete",
		"GitSignsDelete", "GitSignsTopdelete", "GitSignsChangedelete",
		"GitSignsDeleteNr", "GitSignsTopdeleteNr", "GitSignsChangedeleteNr",
		"GitSignsDeleteLn", "GitSignsTopdeleteLn", "GitSignsChangedeleteLn",
		"netrwDir", "TelescopeMatching", "BlinkCmpLabelMatch",
		"NvimInternalError", "RedrawDebugClear", "RedrawDebugComposed", "RedrawDebugRecompose",
	},
}
vim.g.terminal_mono_palette = {
	foreground = terminal_mono.foreground,
	background = terminal_mono.background,
	gray = terminal_mono.gray,
	accent = terminal_mono.accent,
}

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

	set(terminal_mono.code, "ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE")
	set(terminal_mono.keywords, terminal_mono.accent)
	set(terminal_mono.noise, terminal_mono.gray)
	set(terminal_mono.signal, terminal_mono.accent)
	set({ "Visual", "VisualNOS", "Search", "IncSearch", "CurSearch", "Substitute", "PmenuSel", "WildMenu", "BlinkCmpMenuSelection", "BlinkCmpDocCursorLine" }, terminal_mono.selection)
	set({ "TelescopeSelection" }, "ctermfg=NONE ctermbg=NONE cterm=NONE")
	set({ "Pmenu", "BlinkCmpMenu" }, terminal_mono.foreground .. " " .. terminal_mono.background .. " cterm=NONE")
	set({ "BlinkCmpMenuBorder", "BlinkCmpLabel", "BlinkCmpLabelDetail", "BlinkCmpLabelDescription", "BlinkCmpSource", "BlinkCmpKind" }, terminal_mono.gray .. " " .. terminal_mono.background .. " cterm=NONE")
	set({ "PmenuSel", "BlinkCmpMenuSelection" }, terminal_mono.selection)
	set({ "BlinkCmpLabelMatch" }, terminal_mono.accent .. " " .. terminal_mono.background .. " cterm=NONE")
	set({ "DiagnosticUnderlineError", "DiagnosticUnderlineWarn", "DiagnosticUnderlineInfo", "DiagnosticUnderlineHint" }, "cterm=underline")
	set({ "StatusLine", "StatusLineNC" }, terminal_mono.gray .. " ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE")

	vim.api.nvim_set_hl(0, "MatchParen", { bold = true, underline = true })
	vim.cmd("highlight PmenuThumb " .. terminal_mono.selection)
	vim.cmd("highlight DiagnosticVirtualTextError " .. terminal_mono.accent)
end

_G.apply_terminal_mono = terminal_mono.apply
terminal_mono.apply()

function terminal_mono.audit()
	local allowed_cterm = { [3] = true, [8] = true }
	local leaks = {}

	for group, spec in pairs(vim.api.nvim_get_hl(0, {})) do
		for _, field in ipairs({ "fg", "bg" }) do
			if spec[field] ~= nil then
				table.insert(leaks, ("%s.%s=%s"):format(group, field, spec[field]))
			end
		end

		for _, field in ipairs({ "ctermfg", "ctermbg" }) do
			local value = spec[field]
			if value ~= nil and not allowed_cterm[value] then
				table.insert(leaks, ("%s.%s=%s"):format(group, field, value))
			end
		end
	end

	table.sort(leaks)
	if #leaks > 0 then
		error("terminal-mono palette leaks:\n" .. table.concat(leaks, "\n"))
	end

	return true
end

vim.api.nvim_create_user_command("TerminalMonoAudit", function()
	terminal_mono.audit()
	print("terminal-mono palette audit passed")
end, {})
