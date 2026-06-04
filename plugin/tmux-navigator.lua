local pack = require("config.vim-pack")

if not os.getenv("TMUX") then
    return
end

pack.add({
    {
        src = "alexghergh/nvim-tmux-navigation",
        module_name = "nvim-tmux-navigation",
        opts = {
            disable_when_zoomed = true,
        },
        on_setup = function()
            local tmn = require("nvim-tmux-navigation")
            vim.keymap.del("n", "<C-h>")
            vim.keymap.del("n", "<C-j>")
            vim.keymap.del("n", "<C-k>")
            vim.keymap.del("n", "<C-l>")
            vim.keymap.set("n", "<C-h>", tmn.NvimTmuxNavigateLeft, { desc = "Move focus to the left window" })
            vim.keymap.set("n", "<C-j>", tmn.NvimTmuxNavigateDown, { desc = "Move focus to the lower window" })
            vim.keymap.set("n", "<C-k>", tmn.NvimTmuxNavigateUp, { desc = "Move focus to the upper window" })
            vim.keymap.set("n", "<C-l>", tmn.NvimTmuxNavigateRight, { desc = "Move focus to the right window" })
        end,
    },
})
