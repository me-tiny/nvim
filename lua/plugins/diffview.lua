return {
    {
        "dlyongemallo/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        opts = {},
        keys = {
            { "<Leader>gvs", "<CMD>DiffviewOpen<CR>", desc = "Show", silent = true },
            { "<Leader>gvc", "<CMD>DiffviewClose<CR>", desc = "Close", silent = true },
        },
    },
    -- "esmuellert/vscode-diff.nvim",
    -- branch = "next",
    -- dependencies = { "MunifTanjim/nui.nvim" },
    -- keys = {
    --     { "<Leader>gvs", "<CMD>CodeDiff<CR>", silent = true },
    -- },
}
