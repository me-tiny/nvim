return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                float = {
                    transparent = false,
                    solid = true,
                },
                integrations = {
                    fidget = true,
                    diffview = true,
                    mason = true,
                    snacks = {
                        enabled = true,
                        indent_scope_color = "lavender",
                    },
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
                custom_highlights = function()
                    return {
                        ["@comment.todo"] = { link = "Comment" },
                        ["Todo"] = { link = "Comment" },
                    }
                end,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
