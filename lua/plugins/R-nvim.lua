return {
    {
        "R-nvim/R.nvim",
        ft = { "r", "rmd", "quarto" },
        opts = {
            hook = {
                on_filetype = function()
                    vim.keymap.set("n", "<Enter>", "<Plug>RDSendLine", { buffer = 0 })
                    vim.keymap.set("v", "<Enter>", "<Plug>RDSendSelection", { buffer = 0 })
                    require("which-key").add({
                        { "<Leader>r", group = "R", icon = "󰟔" },
                    })
                end,
            },
            disable_cmds = { "RInsertPipe" },
            R_args = { "--quiet", "--no-save" },
            rconsole_width = 78,
        },
    },
}
