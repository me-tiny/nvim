local pack = require("config.vim-pack")
local parsers = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "diff",
    "gdscript",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "html",
    "javascript",
    "json",
    "latex",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "r",
    "rnoweb",
    "rust",
    "scss",
    "svelte",
    "toml",
    "tsx",
    "typescript",
    "typst",
    "vim",
    "vimdoc",
    "xml",
}

pack.add_on_event({ "BufReadPre", "BufNewFile" }, {
    {
        src = "nvim-treesitter/nvim-treesitter",
        on_setup = function()
            local init = vim.api.nvim_get_runtime_file("lua/nvim-treesitter/init.lua", false)[1]
            if init then
                vim.opt.runtimepath:prepend(vim.fn.fnamemodify(init, ":h:h:h") .. "/runtime")
            end
        end,
    },
})

pack.on_plugin_update("nvim-treesitter", function()
    require("nvim-treesitter").install(parsers):wait(300000)
    require("nvim-treesitter").update()
end)
