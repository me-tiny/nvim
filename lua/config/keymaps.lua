-- clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohl<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<Leader>q", vim.diagnostic.setqflist, { desc = "Quickfix list" })

-- Rebinds arrowkeys to use hjkl while using Glove80
vim.keymap.set("n", "<Left>", "h", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "j", { noremap = true, silent = true })
vim.keymap.set("n", "<Up>", "k", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "l", { noremap = true, silent = true })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

vim.keymap.set("n", "<C-Left>", "<C-h>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-Down>", "<C-j>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-Up>", "<C-k>", { noremap = false, silent = true })
vim.keymap.set("n", "<C-Right>", "<C-l>", { noremap = false, silent = true })

-- Remove
for _, bind in ipairs({ "gri", "grr" }) do
    pcall(vim.keymap.del, "n", bind)
end

-- Snacks
vim.keymap.set("n", "<Leader>n", function()
    Snacks.picker.notifications()
end, { desc = "Notification History" })
vim.keymap.set("n", "<Leader>fc", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Config" })
vim.keymap.set("n", "<Leader>ff", function()
    Snacks.picker.files({ hidden = true })
end, { desc = "Files" })
vim.keymap.set("n", "<Leader>fi", function()
    Snacks.picker.icons()
end, { desc = "Icons" })
vim.keymap.set("n", "<Leader>fh", function()
    Snacks.picker.help()
end, { desc = "Help" })
vim.keymap.set("n", "<Leader>fd", function()
    Snacks.picker.diagnostics_buffer()
end, { desc = "Diagnostics (Buffer)" })
vim.keymap.set("n", "<Leader>fD", function()
    Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<Leader>fg", function()
    Snacks.picker.grep()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<Leader>fu", function()
    Snacks.picker.undo()
end, { desc = "Undotree" })
vim.keymap.set("n", "<Leader>fb", function()
    Snacks.picker.lines()
end, { desc = "Grep Buffer" })
vim.keymap.set("n", "<Leader>ft", function()
    Snacks.picker.todo_comments()
end, { desc = "Todo" })

-- Conform
vim.keymap.set("", "<Leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
