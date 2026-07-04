local function map(keys, func, opts, mode)
    mode = mode or "n"
    opts = type(opts) == "string" and { desc = opts } or opts
    vim.keymap.set(mode, keys, func, opts)
end

map("<Esc>", "<CMD>nohl|dif<CR>")

map("<Leader>q", "<CMD>copen<CR>", "Quickfix open")
map("<Leader>Q", "<CMD>cclose<CR>", "Quickfix close")

map("<Left>", "h", { noremap = true, silent = true })
map("<Down>", "j", { noremap = true, silent = true })
map("<Up>", "k", { noremap = true, silent = true })
map("<Right>", "l", { noremap = true, silent = true })

map("<C-h>", "<C-w><C-h>", "Focus left", { "n", "v" })
map("<C-j>", "<C-w><C-j>", "Focus down", { "n", "v" })
map("<C-k>", "<C-w><C-k>", "Focus up", { "n", "v" })
map("<C-l>", "<C-w><C-l>", "Focus right", { "n", "v" })

map("<C-Left>", "<C-h>", { remap = true, silent = true }, { "n", "v" })
map("<C-Down>", "<C-j>", { remap = true, silent = true }, { "n", "v" })
map("<C-Up>", "<C-k>", { remap = true, silent = true }, { "n", "v" })
map("<C-Right>", "<C-l>", { remap = true, silent = true }, { "n", "v" })

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
