local function map(keys, func, opts, mode)
    mode = mode or "n"
    opts = type(opts) == "string" and { desc = opts } or opts
    vim.keymap.set(mode, keys, func, opts)
end

map("<Esc>", "<Cmd>nohl<CR>")

map("<Leader>q", "<CMD>copen<CR>", "Quickfix open")
map("<Leader>Q", "<CMD>cclose<CR>", "Quickfix close")

map("<Left>", "h", { noremap = true, silent = true })
map("<Down>", "j", { noremap = true, silent = true })
map("<Up>", "k", { noremap = true, silent = true })
map("<Right>", "l", { noremap = true, silent = true })

map("<C-h>", "<C-w><C-h>", "Move focus to the left window")
map("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
map("<C-k>", "<C-w><C-k>", "Move focus to the upper window")
map("<C-l>", "<C-w><C-l>", "Move focus to the right window")

map("n", "<C-Left>", "<C-h>", { noremap = false, silent = true })
map("n", "<C-Down>", "<C-j>", { noremap = false, silent = true })
map("n", "<C-Up>", "<C-k>", { noremap = false, silent = true })
map("n", "<C-Right>", "<C-l>", { noremap = false, silent = true })

map("<Leader>fm", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end, "Format Buffer", "")

map("<Leader>ch", "<CMD>LspClangdSwitchSourceHeader<CR>", { desc = "Switch source/header (C/C++)", silent = true })

map("[e", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, "Previous Error")
map("]e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, "Next Error")
