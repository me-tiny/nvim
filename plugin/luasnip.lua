local pack = require("config.vim-pack")

pack.add({
    {
        src = "rafamadriz/friendly-snippets",
        setup = false,
    },
    {
        src = "L3MON4D3/LuaSnip",
        module_name = "luasnip",
        opts = {},
    },
})

pack.on_plugin_update("LuaSnip", function()
    local path = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", "LuaSnip")
    vim.system({ "make", "install_jsregexp" }, { cwd = path }):wait()
end)
