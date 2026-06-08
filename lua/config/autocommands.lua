local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TextYankPost", {
    callback = function()
        vim.hl.hl_op({ higroup = "CurSearch", timeout = 200 })
    end,
    group = augroup("highlight-on-yank", { clear = true }),
    desc = "Highlight when yanking text",
})

autocmd("FileType", {
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
    group = augroup("disable-comment-new-line", { clear = true }),
    desc = "Disable new line comment",
})

autocmd("FileType", {
    pattern = { "markdown", "gitcommit", "text", "typst" },
    callback = function()
        if vim.bo.filetype ~= "typst" then
            vim.opt_local.textwidth = 80
            vim.opt_local.wrap = true
        end
        vim.opt_local.spell = true
    end,
    group = augroup("spellcheck-for-text", { clear = true }),
    desc = "Spellcheck for text files",
})

autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
    group = augroup("reload-on-file-change", { clear = true }),
    desc = "Reload file if changed",
})

autocmd({ "VimResized" }, {
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
    group = augroup("resize_splits", { clear = true }),
    desc = "Resize splits if window is resized",
})

autocmd("QuickFixCmdPost", {
    pattern = { "grep", "grepadd", "lgrep" },
    command = "botright cwindow",
    group = augroup("grep-quickfix", { clear = true }),
    desc = "Open quickfix after :grep",
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    once = true,
    callback = function()
        require("config/lsp")
    end,
    group = augroup("defer-lsp-load", { clear = true }),
    desc = "Defer load LSP config",
})

-- Defer friendly-snippets loading and filetype_extend
-- autocmd("VimEnter", {
--     callback = function()
--         vim.defer_fn(function()
--             local ls = require("luasnip")
--             ls.filetype_extend("python", { "pydoc" })
--             ls.filetype_extend("lua", { "luadoc" })
--             ls.filetype_extend("rust", { "rustdoc" })
--             ls.filetype_extend("cpp", { "cppdoc" })
--             ls.filetype_extend("c", { "cdoc" })
--             require("luasnip.loaders.from_vscode").lazy_load({
--                 paths = {
--                     vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", "friendly-snippets"),
--                 },
--             })
--         end, 100)
--     end,
--     group = augroup("luasnip_extend", { clear = true }),
--     desc = "Extend luasnip fts with docstrings",
-- })

autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        vim.schedule(function()
            pcall(vim.treesitter.start, args.buf)
        end)
    end,
    group = augroup("treesitter-highlighting", { clear = true }),
    desc = "Try enable tree-sitter highlighting",
})

-- Luasnip unlink snippet
-- autocmd("InsertLeave", {
--     callback = function()
--         if
--             require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
--             and not require("luasnip").session.jump_active
--         then
--             require("luasnip").unlink_current()
--         end
--     end,
--     group = augroup("unlink_luasnip", { clear = true }),
--     desc = "Unlinks snippet on insert leave",
-- })
