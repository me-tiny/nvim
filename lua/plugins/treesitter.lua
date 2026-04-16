return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-context",
                opts = {
                    max_lines = 4,
                    multiline_threshold = 2,
                    min_window_height = 20,
                },
                keys = {
                    {
                        "[c",
                        function()
                            if vim.wo.diff then
                                return "[c"
                            else
                                vim.schedule(function()
                                    require("treesitter-context").go_to_context()
                                end)
                                return "<Ignore>"
                            end
                        end,
                        desc = "Jump to upper context",
                        expr = true,
                    },
                },
            },
        },
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.install({
                "bash",
                "c",
                "comment",
                "cpp",
                "css",
                "diff",
                "gdscript",
                "git_config",
                "git_rebase",
                "gitcommit",
                "gitignore",
                "html",
                "javascript",
                "json",
                "latex",
                "lua",
                "luadoc",
                "make",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "r",
                "rnoweb",
                "rust",
                "scss",
                "svelte",
                "toml",
                "tsx",
                "typescript",
                "typst",
                "vim",
                "vimdoc",
                "xml",
            }, { max_jobs = 8 })

            -- local ts_group = vim.api.nvim_create_augroup("treesitter-setup", { clear = true })
            -- local ignore_ft = {
            --     "checkhealth",
            --     "lazy",
            -- }

            -- TODO: spams warning messages, find better way
            -- https://github.com/nvim-treesitter/nvim-treesitter/commit/1927c76aec829d40dcad24b6469cb639f1334096
            -- vim.api.nvim_create_autocmd("FileType", {
            --     group = ts_group,
            --     desc = "Enable treesitter highlighting",
            --     callback = function(event)
            --         if vim.tbl_contains(ignore_ft, event.match) then
            --             return
            --         end
            --
            --         local lang = vim.treesitter.language.get_lang(event.match) or event.match
            --         local buf = event.buf
            --         pcall(vim.treesitter.start, buf, lang)
            --         vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            --         ts.install({ lang })
            --     end,
            -- })
        end,
    },
}
