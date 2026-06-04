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
            local obsidian = require("obsidian")

            vim.keymap.set(
                "n",
                "<CR>",
                obsidian.api.smart_action,
                { expr = true, buffer = true, desc = "Obsidian smart action" }
            )
            vim.keymap.set("n", "<Leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open in Obsidian " })
            vim.keymap.set("n", "<Leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Backlinks" })
            vim.keymap.set("n", "<Leader>ol", "<cmd>Obsidian links<CR>", { desc = "Links" })
            vim.keymap.set("n", "<Leader>on", "<cmd>Obsidian new<CR>", { desc = "Create note" })
            vim.keymap.set("n", "<Leader>os", "<cmd>Obsidian search<CR>", { desc = "Search" })
            vim.keymap.set("n", "<Leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick switch" })
            vim.keymap.set("n", "<Leader>op", "<cmd>Obsidian paste_img<CR>", { desc = "Paste image" })
            vim.keymap.set(
                "n",
                "<Leader>ok",
                ":!mv '%:p' ~/Documents/Obsidian/Main/uncategorised<CR>:bd<CR>",
                { desc = "Move to uncategorised", silent = true }
            )
            vim.keymap.set("n", "<Leader>odd", ":!rm '%:p'<CR>:bd<CR>", { desc = "Delete file", silent = true })

            -- -- Obsidian specific live grep folders
            -- local inbox = vault_path .. "/inbox"
            -- local notes = vault_path .. "/notes"
            -- local uncat = vault_path .. "/uncategorised"
            --
            -- vim.keymap.set("n", "<Leader>fg", function()
            --     Snacks.picker.grep({ dirs = { inbox, notes, uncat }, title = "Vault (Grep)" })
            -- end, { desc = "Grep (Obsidian)", noremap = true })
            --
            -- vim.keymap.set("n", "<Leader>ff", function()
            --     Snacks.picker.files({ dirs = { inbox, notes, uncat }, title = "Vault" })
            -- end, { desc = "Find Files (Obsidian)", noremap = true })
        end,
    },
})
