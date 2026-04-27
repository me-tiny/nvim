return {
    {
        "saghen/blink.cmp",
        event = "VeryLazy",
        build = function()
            require("blink.cmp").build():wait(60000)
        end,
        dependencies = {
            "saghen/blink.lib",
        },
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
                    auto_show_delay_ms = 1,
                    min_width = 15,
                    max_height = 10,
                    draw = {
                        gap = 2,
                        treesitter = { "lsp" },
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind", "kind_icon", gap = 1 },
                            -- { "source_name", gap = 1 },
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
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                        fallbacks = { "lsp" },
                    },
                    snippets = {
                        min_keyword_length = function(ctx)
                            if ctx.trigger.initial_kind == "trigger_character" then
                                return 0
                            end
                            return 2
                        end,
                        override = {
                            get_trigger_characters = function(_)
                                return { "#", "/" }
                            end,
                        },
                        opts = {
                            prefer_doc_trig = true,
                        },
                    },
                    buffer = {
                        max_items = 5,
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
            appearance = {
                nerd_font_variant = "mono",
                kind_icons = {
                    Array = "󰅪",
                    Class = "",
                    Color = "󰏘",
                    Constant = "󰏿",
                    Constructor = "",
                    Enum = "",
                    EnumMember = "",
                    Event = "",
                    Field = "󰜢",
                    File = "󰈙",
                    Folder = "󰉋",
                    Function = "󰆧",
                    Interface = "",
                    Keyword = "󰌋",
                    Method = "󰆧",
                    Module = "",
                    Operator = "󰆕",
                    Property = "󰜢",
                    Reference = "󰈇",
                    Snippet = "",
                    Struct = "",
                    Text = "",
                    TypeParameter = "",
                    Unit = "",
                    Value = "",
                    Variable = "󰀫",
                },
            },
        },
    },
}
