-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd( 'TextYankPost', {
  desc = 'Highlight when yanking (copying) text | Briefly highlight yanked text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lsp_hishlight = vim.api.nvim_create_augroup('lsp-hishlight', { clear = false })

-- Highlight refrences of the word under the cursor
vim.api.nvim_create_autocmd({'CursorMoved', 'cursorMovedI'}, {
  desc = 'Highlight refrences of the word under the cursor',
  group = lsp_hishlight,
  pattern = {'*.c', '*.h', '*.py', '*.rs', '*.lua', '*.nix', '*.js', '*.ts', '*.jsx', '*.tsx', '*.zig'},
  callback = vim.lsp.buf.document_highlight,
})

-- Highlight refrences of the word under the cursor
vim.api.nvim_create_autocmd({'CursorMoved', 'cursorMovedI'}, {
  desc = 'Highlight refrences of the word under the cursor',
  group = lsp_hishlight,
  pattern = {'*.c', '*.h', '*.py', '*.rs', '*.lua', '*.nix', '*.js', '*.ts', '*.jsx', '*.tsx', '*.zig'},
  callback = vim.lsp.buf.clear_references,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Zig: build on save and show compiler diagnostics inline
local zig_diag_ns = vim.api.nvim_create_namespace("zig-build")

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Run zig build on save and report diagnostics",
  group = vim.api.nvim_create_augroup("zig-build-on-save", { clear = true }),
  pattern = "*.zig",
  callback = function(ev)
    local root = vim.fs.root(ev.buf, { "build.zig" })
    if not root then return end

    vim.system(
      { "zig", "build" },
      { cwd = root, text = true },
      vim.schedule_wrap(function(result)
        vim.diagnostic.reset(zig_diag_ns)

        local output = (result.stderr or "") .. (result.stdout or "")
        if output == "" then return end

        local diags_by_file = {}
        for file, line, col, severity, msg in output:gmatch("([^\n]-):(%d+):(%d+): (%w+): ([^\n]+)") do
          local path = file
          if not vim.startswith(path, "/") then
            path = root .. "/" .. path
          end
          path = vim.fs.normalize(path)

          if not diags_by_file[path] then
            diags_by_file[path] = {}
          end

          local sev = vim.diagnostic.severity.ERROR
          if severity == "warning" then
            sev = vim.diagnostic.severity.WARN
          elseif severity == "note" then
            sev = vim.diagnostic.severity.INFO
          end

          table.insert(diags_by_file[path], {
            lnum = tonumber(line) - 1,
            col = tonumber(col) - 1,
            message = msg,
            severity = sev,
            source = "zig build",
          })
        end

        for path, diags in pairs(diags_by_file) do
          local bufnr = vim.fn.bufnr(path)
          if bufnr ~= -1 then
            vim.diagnostic.set(zig_diag_ns, bufnr, diags)
          end
        end
      end)
    )
  end,
})
