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
vim.o.colorcolumn = "100"
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
vim.o.foldlevelstart = 99

vim.opt.path:append("**")
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "fuzzy,pum"
vim.o.wildignorecase = true
vim.o.grepprg = "rg --vimgrep --smart-case --hidden --glob=!.git"
vim.o.grepformat = "%f:%l:%c:%m"
vim.cmd.cnoreabbrev("<expr> grep (getcmdtype() == ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'")
require("util.find").setup()

-- disable native plugins
vim.g.loaded_gzip = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- diagnostic setup
vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = { border = "none", source = "if_many" },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
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
            emsg = "msg",
            echoerr = "msg",
            wmsg = "msg",

            lua_error = "pager",
            lua_print = "pager",
            rpc_error = "pager",
            shell_cmd = "pager",
            shell_out = "pager",
            shell_err = "pager",
            shell_ret = "pager",
            verbose = "pager",

            [""] = "cmd",
            empty = "cmd",
            echo = "cmd",
            echomsg = "cmd",
            confirm = "cmd",
            completion = "cmd",
            list_cmd = "cmd",
            quickfix = "cmd",
            search_cmd = "cmd",
            search_count = "cmd",
            progress = "cmd",
            undo = "cmd",
            wildlist = "cmd",
            bufwrite = "cmd",
            typed_cmd = "cmd",
        },
        cmd = {
            height = 0.5,
        },
        dialog = {
            height = 0.5,
        },
        msg = {
            height = 0.25,
            timeout = 5000,
        },
        pager = {
            height = 0.5,
        },
    },
})
