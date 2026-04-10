return {
    {
        "obsidian-nvim/obsidian.nvim",
        -- dir = "~/Developer/obsidian.nvim",
        version = "*",
        -- event = "VeryLazy",
        -- ft = "markdown",
        cond = function()
            local cwd = vim.fn.getcwd()
            local home = vim.fn.expand("~")
            local vault_path = home .. "/Documents/Obsidian/Main"
            return string.find(cwd, vault_path)
        end,
        opts = {
            workspaces = {
                {
                    name = "Main",
                    path = vim.fn.expand("~") .. "/Documents/Obsidian/Main",
                },
            },
            notes_subdir = "inbox",
            new_notes_location = "notes_subdir",
            legacy_commands = false,
            sync = { enabled = true },
            completion = {
                blink = true,
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
        config = function(_, opts)
            local obsidian = require("obsidian")

            obsidian.setup(opts)

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

            -- Obsidian specific live grep folders
            local vault_root = vim.fn.expand("~/Documents/Obsidian/Main")
            local inbox = vault_root .. "/inbox"
            local notes = vault_root .. "/notes"
            local uncat = vault_root .. "/uncategorised"

            vim.keymap.set("n", "<Leader>fg", function()
                Snacks.picker.grep({ dirs = { inbox, notes, uncat }, title = "Vault (Grep)" })
            end, { desc = "Grep (Obsidian)", noremap = true })

            vim.keymap.set("n", "<Leader>ff", function()
                Snacks.picker.files({ dirs = { inbox, notes, uncat }, title = "Vault" })
            end, { desc = "Find Files (Obsidian)", noremap = true })
        end,
    },
}
