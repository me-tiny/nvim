local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ timeout = 200 })
    end,
    group = augroup("highlight-on-yank", { clear = true }),
    desc = "Highlight when yanking text",
})

autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    group = augroup("disable-comment-new-line", { clear = true }),
    desc = "Disable new line comment",
})

autocmd("FileType", {
    pattern = { "markdown", "gitcommit", "text", "typst" },
    callback = function()
        if vim.bo.filetype ~= "typst" then
            vim.o.textwidth = 80
            vim.o.wrap = true
        end
        vim.o.spell = true
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

-- Defer friendly-snippets loading and filetype_extend
autocmd("VimEnter", {
    callback = function()
        vim.defer_fn(function()
            local ls = require("luasnip")
            ls.filetype_extend("python", { "pydoc" })
            ls.filetype_extend("lua", { "luadoc" })
            ls.filetype_extend("rust", { "rustdoc" })
            ls.filetype_extend("cpp", { "cppdoc" })
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = {
                    vim.fn.stdpath("data") .. "/lazy/friendly-snippets",
                },
            })
        end, 100)
    end,
})

-- Treesitter highlighting
-- autocmd("FileType", {
--     pattern = "*",
--     callback = function()
--         pcall(function()
--             vim.treesitter.start()
--         end)
--     end,
--     group = augroup("treesitter-highlighting", { clear = true }),
--     desc = "Try enable tree-sitter highlighting",
-- })

-- Luasnip unlink snippet
autocmd("InsertLeave", {
    callback = function()
        if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
        then
            require("luasnip").unlink_current()
        end
    end,
})
