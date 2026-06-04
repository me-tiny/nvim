local pack = require("config.vim-pack")

pack.add_on_file_type({ "markdown", "gitcommit" }, {
    {
        src = "MeanderingProgrammer/render-markdown.nvim",
        module_name = "render-markdown",
        opts = {
            debounce = 5,
            win_options = {
                conceallevel = {
                    default = 0,
                    rendered = 2,
                },
            },
        },
        on_setup = function()
            vim.keymap.set("n", "<leader>mt", function()
                require("render-markdown").toggle()
            end, { desc = "Toggle Markdown Render" })
        end,
    },
})
