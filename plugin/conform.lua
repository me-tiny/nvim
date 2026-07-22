local pack = require("config.vim-pack")

pack.add_on_event({ "BufReadPre", "BufNewFile" }, {
    {
        src = "stevearc/conform.nvim",
        opts = {
            notify_on_error = true,
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
            formatters_by_ft = {
                css = { "prettierd" },
                go = { "gofmt" },
                html = { "superhtml" },
                lua = { "stylua" },
                markdown = { "prettierd" },
                php = { "php_cs_fixer" },
                python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
            },
            formatters = {
                php_cs_fixer = {
                    args = {
                        "fix",
                        '--rules={"curly_braces_position": {"classes_opening_brace": "same_line", "functions_opening_brace": "same_line"}}',
                        "$FILENAME",
                    },
                },
            },
        },
    },
})
