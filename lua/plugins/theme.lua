return {
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                variant = "main",
                extend_background_behind_borders = false,
                highlight_groups = {
                    WhichKeyBorder = { link = "FloatBorder" },
                },
                before_highlight = function(group, highlight, palette)
                    if group == "FloatBorder" then
                        highlight.fg = palette.base
                        highlight.bg = palette.base
                    end
                    if group == "NormalFloat" then
                        highlight.bg = palette.base
                    end
                end,
            })
            vim.cmd.colorscheme("rose-pine")
        end,
    },
    -- {
    --     "webhooked/kanso.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("kanso").setup({
    --             background = {
    --                 dark = "zen",
    --             },
    --             foreground = "default",
    --             overrides = function(colors)
    --                 return {
    --                     ["@comment.todo"] = { link = "Comment" },
    --                     ["Todo"] = { link = "Comment" },
    --                 }
    --             end,
    --         })
    --         vim.cmd.colorscheme("kanso")
    --     end,
    -- },
    -- {
    --     "oskarnurm/koda.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("koda").setup({
    --             theme = {
    --                 dark = "dark",
    --             },
    --             transparent = false,
    --             cache = false,
    --             styles = {
    --                 keywords = { italic = true },
    --                 comments = { italic = true },
    --             },
    --             on_highlights = function(hl, c)
    --                 hl.SnacksPickerBorder = {
    --                     bg = c.bg,
    --                     fg = c.bg,
    --                 }
    --             end,
    --         })
    --
    --         vim.cmd.colorscheme("koda")
    --     end,
    -- },
    -- {
    --     "catppuccin/nvim",
    --     name = "catppuccin",
    --     priority = 1000,
    --     config = function()
    --         require("catppuccin").setup({
    --             flavour = "mocha",
    --             float = {
    --                 transparent = false,
    --                 solid = true,
    --             },
    --             integrations = {
    --                 fidget = true,
    --                 diffview = true,
    --                 mason = true,
    --                 snacks = {
    --                     enabled = true,
    --                     indent_scope_color = "lavender",
    --                 },
    --             },
    --             lsp_styles = {
    --                 enabled = true,
    --                 underlines = {
    --                     errors = { "undercurl" },
    --                     hints = { "undercurl" },
    --                     warnings = { "undercurl" },
    --                     information = { "undercurl" },
    --                 },
    --             },
    --             custom_highlights = function()
    --                 return {
    --                     ["@comment.todo"] = { link = "Comment" },
    --                     ["Todo"] = { link = "Comment" },
    --                 }
    --             end,
    --         })
    --         vim.cmd.colorscheme("catppuccin")
    --     end,
    -- },
}
