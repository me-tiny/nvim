local pack = require("config.vim-pack")

pack.add_on_file_type("typst", {
    {
        src = "chomosuke/typst-preview.nvim",
        opts = {
            dependencies_bin = {
                ["tinymist"] = "tinymist",
            },
        },
        on_setup = function()
            vim.keymap.set("n", "<Leader>p", "<CMD>TypstPreview<CR>", { silent = true })
        end,
    },
})
