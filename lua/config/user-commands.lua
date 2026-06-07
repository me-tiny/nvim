local cmd = vim.api.nvim_create_user_command

cmd("Grep", function(o)
    vim.cmd("silent grep! " .. o.args)
end, { nargs = "+", complete = "file_in_path", bar = true, desc = "Silent grep" })
