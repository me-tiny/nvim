local pack = require("config.vim-pack")

pack.add_on_event({ "BufReadPre", "BufNewFile" }, {
    {
        src = "kylechui/nvim-surround",
        opts = {},
    },
})
