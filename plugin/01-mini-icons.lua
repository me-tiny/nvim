local pack = require("config.vim-pack")

pack.add({
    {
        src = "nvim-mini/mini.icons",
        opts = {
            filetype = {
                dotenv = { glyph = "", hl = "MiniIconsYellow" },
            },
        },
        on_setup = function()
            package.preload["nvim-web-devicons"] = function()
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
    },
})
