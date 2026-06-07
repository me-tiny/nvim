local pack = require("config.vim-pack")

pack.add_on_event({ "BufReadPre", "BufNewFile" }, {
    {
        src = "NMAC427/guess-indent.nvim",
        opts = {},
    },
})
