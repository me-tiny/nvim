local pack = require("config.vim-pack")

pack.add_on_event("InsertEnter", {
    {
        src = "rafamadriz/friendly-snippets",
        setup = false,
    },
    {
        src = "L3MON4D3/LuaSnip",
        module_name = "luasnip",
        opts = {},
        on_setup = function()
            local ls = require("luasnip")
            ls.filetype_extend("c", { "cdoc" })
            ls.filetype_extend("cpp", { "cppdoc" })
            ls.filetype_extend("lua", { "luadoc" })
            ls.filetype_extend("python", { "pydoc" })
            ls.filetype_extend("rust", { "rustdoc" })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    { src = "saghen/blink.lib", setup = false },
    {
        src = "saghen/blink.cmp",
        build = function()
            require("blink.cmp").build():pwait()
        end,
        opts = {
            snippets = {
                preset = "luasnip",
            },
            cmdline = {
                enabled = false,
            },
            completion = {
                list = { selection = { preselect = true, auto_insert = false } },
                menu = {
                    auto_show_delay_ms = 0,
                    min_width = 15,
                    max_height = 10,
                    draw = {
                        treesitter = { "lsp" },
                        columns = {
                            { "label", gap = 1 },
                        },
                    },
                    scrollbar = false,
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 50,
                    treesitter_highlighting = true,
                    update_delay_ms = 50,
                    window = {
                        min_width = 10,
                        max_width = 60,
                        max_height = 20,
                    },
                },
                ghost_text = {
                    enabled = false,
                },
            },
            signature = {
                enabled = true,
                window = {
                    show_documentation = false,
                },
            },
            sources = {
                default = { "lsp", "buffer", "path", "snippets" },
                providers = {
                    buffer = { max_items = 5 },
                    snippets = {
                        enabled = function()
                            local ok, node = pcall(vim.treesitter.get_node)
                            if not (ok and node) then
                                return true
                            end
                            local string_types = {
                                "string",
                                "string_content",
                                "string_literal",
                                "string_fragment",
                                "raw_string_literal",
                                "interpreted_string_literal",
                                "template_string",
                            }
                            return not vim.tbl_contains(string_types, node:type())
                        end,
                        should_show_items = function(ctx)
                            return ctx.trigger.initial_kind ~= "trigger_character"
                        end,
                    },
                    path = {
                        enabled = function()
                            local ok, node = pcall(vim.treesitter.get_node)
                            if not (ok and node) then
                                return true
                            end
                            local comment_types = { "comment", "line_comment", "block_comment" }
                            return not vim.tbl_contains(comment_types, node:type())
                        end,
                    },
                },
            },
            keymap = {
                preset = "none",
                ["<C-n>"] = { "select_next", "fallback_to_mappings" },
                ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
                ["<Up>"] = { "scroll_documentation_up", "fallback" },
                ["<Down>"] = { "scroll_documentation_down", "fallback" },
                ["<C-y>"] = { "select_and_accept", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            },
            fuzzy = {
                implementation = "rust",
            },
        },
    },
})

pack.on_plugin_update("LuaSnip", function(path)
    vim.system({ "make", "install_jsregexp" }, { cwd = path }):wait()
end)
