local function map(keys, func, opts, mode)
    mode = mode or "n"
    opts = type(opts) == "string" and { desc = opts } or opts
    vim.keymap.set(mode, keys, func, opts)
end

-- Remove default bindings (for Snacks rebinding)
for _, bind in ipairs({ "gri", "grr", "grt", "gO" }) do
    pcall(vim.keymap.del, "n", bind)
end

-- Clear highlights
map("<Esc>", "<Cmd>nohl<CR>")

-- Diagnostic keymaps
map("<Leader>q", vim.diagnostic.setqflist, "Quickfix List")

-- Rebinds arrowkeys to use hjkl while using Glove80
map("<Left>", "h", { noremap = true, silent = true })
map("<Down>", "j", { noremap = true, silent = true })
map("<Up>", "k", { noremap = true, silent = true })
map("<Right>", "l", { noremap = true, silent = true })

-- Split navigation
map("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("<C-k>", "<C-w><C-k>", "Move focus to the upper window")
map("<C-l>", "<C-w><C-l>", "Move focus to the right window")

map("n", "<C-Left>", "<C-h>", { noremap = false, silent = true })
map("n", "<C-Down>", "<C-j>", { noremap = false, silent = true })
map("n", "<C-Up>", "<C-k>", { noremap = false, silent = true })
map("n", "<C-Right>", "<C-l>", { noremap = false, silent = true })

-- Snacks
map("<Leader>n", function()
    Snacks.picker.notifications()
end, "Notification History")
map("<Leader>fc", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config"), title = "Config" })
end, "Config")
map("<Leader>ff", function()
    Snacks.picker.files({ hidden = true })
end, "Files")
map("<Leader>fi", function()
    Snacks.picker.icons()
end, "Icons")
map("<Leader>fh", function()
    Snacks.picker.help()
end, "Help")
map("<Leader>fd", function()
    Snacks.picker.diagnostics_buffer()
end, "Diagnostics (Buffer)")
map("<Leader>fD", function()
    Snacks.picker.diagnostics()
end, "Diagnostics")
map("<Leader>fg", function()
    Snacks.picker.grep()
end, "Grep")
map("<Leader>fb", function()
    Snacks.picker.lines()
end, "Grep Current Buffer")
map("<Leader>fu", function()
    Snacks.picker.undo()
end, "Undotree")
map("<Leader>ft", function()
    Snacks.picker.todo_comments()
end, "Todo")

-- Conform
map("<Leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, "Format Buffer", "")
