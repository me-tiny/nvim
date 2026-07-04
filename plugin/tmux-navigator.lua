local pack = require("config.vim-pack")

if not os.getenv("TMUX") then
    return
end

pack.add_on_event("VimEnter", {
    {
        src = "alexghergh/nvim-tmux-navigation",
        module_name = "nvim-tmux-navigation",
        opts = {
            disable_when_zoomed = true,
        },
        on_setup = function()
            local tmn = require("nvim-tmux-navigation")

            vim.keymap.set({ "n", "v" }, "<C-h>", tmn.NvimTmuxNavigateLeft, { desc = "Focus left" })
            vim.keymap.set({ "n", "v" }, "<C-j>", tmn.NvimTmuxNavigateDown, { desc = "Focus down" })
            vim.keymap.set({ "n", "v" }, "<C-k>", tmn.NvimTmuxNavigateUp, { desc = "Focus up" })
            vim.keymap.set({ "n", "v" }, "<C-l>", tmn.NvimTmuxNavigateRight, { desc = "Focus right" })
        end,
    },
})
