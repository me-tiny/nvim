local pack = require("config.vim-pack")

pack.add({
    {
        src = "catppuccin/nvim",
        module_name = "catppuccin",
        opts = {
            flavour = "mocha",
            float = {
                transparent = false,
                solid = true,
            },
            integrations = {
                -- diffview = true,
                -- snacks = {
                --     enabled = true,
                -- },
            },
            lsp_styles = {
                enabled = true,
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
        },
        on_setup = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
})
