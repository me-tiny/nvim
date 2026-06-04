local pack = require("config.vim-pack")

pack.add({
    {
        src = "nvim-treesitter/nvim-treesitter",
        version = "main",
        setup = false,
        on_setup = function()
            require("nvim-treesitter").install({
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
            }, { max_jobs = 8 })
        end,
    },
})

pack.on_plugin_update("nvim-treesitter", function()
    if not pcall(vim.cmd, "TSUpdate") then
        pcall(function()
            require("nvim-treesitter").update()
        end)
    end
end)
