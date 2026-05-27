return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            notify_on_error = true,
            format_on_save = function(bufnr)
                local disable_filetypes = { c = false, cpp = false }
                if disable_filetypes[vim.bo[bufnr].filetype] then
                    return nil
                else
                    return {
                        timeout_ms = 500,
                        lsp_format = "fallback",
                    }
                end
            end,
            formatters_by_ft = {
                c = { "clang_format" },
                cpp = { "clang_format" },
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
}
