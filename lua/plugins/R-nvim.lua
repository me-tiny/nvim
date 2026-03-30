return {
    {
        "R-nvim/R.nvim",
        ft = { "r", "rmd", "quarto" },
        opts = {
            hook = {
                on_filetype = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
                    vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RDSendSelection", {})
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
