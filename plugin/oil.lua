local pack = require("config.vim-pack")
local loaded = false

vim.keymap.set("n", "<Leader>e", function()
    if not loaded then
        pack.add({
            {
                src = "stevearc/oil.nvim",
                opts = {
                    columns = { "icon", "permissions" },
                    view_options = {
                        show_hidden = true,
                    },
                    delete_to_trash = true,
                    skip_confirm_for_simple_edits = true,
                    use_default_keymaps = false,
                    keymaps = {
                        ["<CR>"] = "actions.select",
                        ["-"] = "actions.parent",
                    },
                },
            },
        })
        loaded = true
    end
    require("oil").open()
end, { desc = "Open Oil" })
