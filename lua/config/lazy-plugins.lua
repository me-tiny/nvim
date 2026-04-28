require("lazy").setup({
    { import = "plugins" },
    { import = "plugins.Notes" },
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "netrwPlugin",
                "rplugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    rocks = {
        enabled = false,
    },
    change_detection = {
        notify = false,
    },
    install = {
        colorscheme = { "rose-pine" },
    },
})
