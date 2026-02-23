return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "helix",
            delay = 200,
            icons = {
                keys = {
                    BS = "󰭜 ", -- Better backspace icon + fix space issue I had
                },
            },
            plugins = {
                spelling = {
                    enabled = true,
                },
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.add({
                -- Obsidian/Markdown
                { "<Leader>o", group = "Obsidian", icon = { icon = "", color = "purple" } },
                { "<Leader>m", group = "Markdown", icon = { icon = "", color = "purple" } },
                -- Oil.nvim icon
                { "<Leader>e", group = "Oil", icon = { icon = "󰏇", color = "red" } },
                -- Trouble
                { "<Leader>x", group = "Diagnostics", icon = { icon = "󰔫", color = "cyan" } },
                { "<Leader>c", group = "Trouble LSP", icon = { icon = "󰔫", color = "cyan" } },
                -- Git
                { "<Leader>g", group = "Git", icon = { name = "git", cat = "filetype" } },
                { "<Leader>g", desc = "Git", mode = "v" },
                { "<Leader>gh", desc = "Hunk", icon = { name = "git", cat = "filetype" } },
                { "<Leader>gv", desc = "Diffview", icon = { name = "git", cat = "filetype" } },
                -- Find Files
                { "<Leader>f", desc = "Find", icon = { icon = "", color = "cyan" } },
                -- Misc
                { "<Leader>t", group = "Toggle", icon = { icon = "", color = "yellow" } },
                wk.setup(opts),
            })
        end,
    },
}
