return {
    {
        "nvim-mini/mini.hipatterns",
        -- TODO: check if attached lsp has documentColor capabilities and load
        --       according to that
        lazy = true,
        opts = {
            hex_color = function()
                require("mini.hipatterns").gen_highlighter.hex_color()
            end,
        },
    },
}
