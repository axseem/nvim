return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = function()
		local builtin = require("telescope.builtin")
		local function root()
			return vim.fs.root(vim.api.nvim_buf_get_name(0), { ".git" }) or vim.fn.getcwd()
		end

		return {
			{ "<leader><space>", function() builtin.find_files({ cwd = root(), hidden = true }) end, desc = "Files" },
			{ "<leader>/", function() builtin.live_grep({ cwd = root() }) end, desc = "Grep" },
			{ "<leader>fb", builtin.buffers, desc = "Buffers" },
			{ "<leader>fr", builtin.oldfiles, desc = "Recent" },
			{ "<leader>sh", builtin.help_tags, desc = "Help" },
			{ "<leader>sk", builtin.keymaps, desc = "Keymaps" },
			{ "<leader>sd", builtin.diagnostics, desc = "Diagnostics" },
		}
	end,
	opts = {
		defaults = {
			prompt_prefix = "> ",
			selection_caret = "> ",
			border = true,
			vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--hidden", "--no-ignore" },
		},
	},
}
