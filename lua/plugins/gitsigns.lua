return {
    {
        "lewis6991/gitsigns.nvim",
        ft = { "gitcommit", "diff" },
        init = function()
            vim.api.nvim_create_autocmd("BufRead", {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.jobstart({ "git", "-C", vim.fn.expand("%:h"), "rev-parse" }, {
                        on_exit = function(_, return_code)
                            if return_code == 0 then
                                vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
                                vim.schedule(function()
                                    require("lazy").load({ plugins = { "gitsigns.nvim" } })
                                end)
                            end
                        end,
                    })
                end,
            })
        end,
        opts = {
            attach_to_untracked = true,
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            signs_staged = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                -- map("n", "]c", function()
                --     if vim.wo.diff then
                --         vim.cmd.normal({ "]c", bang = true })
                --     else
                --         gitsigns.nav_hunk("next")
                --     end
                -- end, { desc = "Jump to next git change" })
                --
                -- map("n", "[c", function()
                --     if vim.wo.diff then
                --         vim.cmd.normal({ "[c", bang = true })
                --     else
                --         gitsigns.nav_hunk("prev")
                --     end
                -- end, { desc = "Jump to previous git change" })

                -- Actions
                -- Visual
                map("v", "<Leader>ghs", function()
                    gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Git Stage Hunk" })
                map("v", "<Leader>ghr", function()
                    gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "Git Reset Hunk" })
                -- Normal
                map("n", "<Leader>ghs", gitsigns.stage_hunk, { desc = "Stage hunk" })
                map("n", "<Leader>ghr", gitsigns.reset_hunk, { desc = "Reset hunk" })
                map("n", "<Leader>ghS", gitsigns.stage_buffer, { desc = "Stage buffer" })
                map("n", "<Leader>ghR", gitsigns.reset_buffer, { desc = "Reset buffer" })
                map("n", "<Leader>ghp", gitsigns.preview_hunk, { desc = "Preview hunk" })
                map("n", "<Leader>ghb", gitsigns.blame_line, { desc = "Blame line" })
                map("n", "<Leader>ghd", gitsigns.diffthis, { desc = "Diff against index" })
                map("n", "<Leader>ghD", function()
                    gitsigns.diffthis("@")
                end, { desc = "Diff against last commit" })
                -- Toggles
                map("n", "<Leader>gtb", gitsigns.toggle_current_line_blame, { desc = "Show blame line" })
                map("n", "<Leader>gtd", gitsigns.preview_hunk_inline, { desc = "Show deleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end,
        },
    },
}
