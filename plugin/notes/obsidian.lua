local pack = require("config.vim-pack")
local cwd = vim.uv.cwd()
local vault_path = vim.uv.os_homedir() .. "/Documents/Obsidian/Main"

if not string.find(cwd, vault_path, 1, true) then
    return
end

pack.add({
    {
        src = "obsidian-nvim/obsidian.nvim",
        version = vim.version.range("*"),
        opts = {
            workspaces = {
                {
                    name = "Main",
                    path = vault_path,
                },
            },
            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",
            legacy_commands = false,
            sync = { enabled = true },
            completion = {
                min_chars = 2,
            },
            frontmatter = {
                enabled = false,
            },
            templates = {
                subdir = "templates",
                date_format = "%Y-%m-%d",
                time_format = "%H:%M",
            },
            checkbox = {
                order = {
                    " ",
                    "x",
                },
            },
            ui = {
                enable = true,
                bullets = {},
            },
            attachments = {
                folder = "images",
            },
            footer = {
                enabled = false,
            },
        },
        on_setup = function()
            vim.keymap.set("n", "<Leader>oo", "<CMD>Obsidian open<CR>", { desc = "Open in Obsidian " })
            vim.keymap.set("n", "<Leader>ob", "<CMD>Obsidian backlinks<CR>", { desc = "Backlinks" })
            vim.keymap.set("n", "<Leader>ol", "<CMD>Obsidian links<CR>", { desc = "Links" })
            vim.keymap.set("n", "<Leader>on", "<CMD>Obsidian new<CR>", { desc = "Create note" })
            vim.keymap.set("n", "<Leader>os", "<CMD>Obsidian search<CR>", { desc = "Search" })
            vim.keymap.set("n", "<Leader>oq", "<CMD>Obsidian quick_switch<CR>", { desc = "Quick switch" })
            vim.keymap.set("n", "<Leader>op", "<CMD>Obsidian paste_img<CR>", { desc = "Paste image" })
            vim.keymap.set(
                "n",
                "<Leader>ok",
                ":!mv '%:p' ~/Documents/Obsidian/Main/uncategorised<CR>:bd<CR>",
                { desc = "Move to uncategorised", silent = true }
            )
            vim.keymap.set("n", "<Leader>odd", ":!rm '%:p'<CR>:bd<CR>", { desc = "Delete file", silent = true })
        end,
    },
})
