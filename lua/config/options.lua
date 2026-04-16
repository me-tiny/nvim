vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.markdown_recommended_style = 0

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cmdheight = 1
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.fillchars = { eob = " " }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.colorcolumn = "80"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.spelllang = "en"
vim.o.smoothscroll = true
vim.o.conceallevel = 2
vim.o.winborder = "none"

-- diagnostic setup
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = "none", source = "if_many" },
    jump = {
        on_jump = function(diagnostic, bufnr)
            if not diagnostic then
                return
            end
            vim.diagnostic.open_float({
                bufnr = bufnr,
                scope = "cursor",
                focus = false,
            })
        end,
    },
    signs = {
        -- gets rid of signs in gutter
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        -- but can color line num
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
            [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticHint",
        },
    },
    virtual_text = {
        current_line = true,
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})

-- ui2
-- stolen from https://old.reddit.com/r/neovim/comments/1sfmgkb/how_does_the_new_ui2_message_cmdline_replacement/oeyrgua/
require("vim._core.ui2").enable({
    enable = true,
    msg = {
        targets = {
            [""] = "msg",
            empty = "cmd",
            bufwrite = "msg",
            confirm = "cmd",
            emsg = "pager",
            echo = "msg",
            echomsg = "msg",
            echoerr = "pager",
            completion = "cmd",
            list_cmd = "pager",
            lua_error = "pager",
            lua_print = "msg",
            progress = "pager",
            rpc_error = "pager",
            quickfix = "msg",
            search_cmd = "cmd",
            search_count = "cmd",
            shell_cmd = "pager",
            shell_err = "pager",
            shell_out = "pager",
            shell_ret = "msg",
            undo = "msg",
            verbose = "pager",
            wildlist = "cmd",
            wmsg = "msg",
            typed_cmd = "cmd",
        },
        cmd = {
            height = 0.5,
        },
        dialog = {
            height = 0.5,
        },
        msg = {
            height = 1,
            timeout = 5000,
        },
        pager = {
            height = 0.5,
        },
    },
})
