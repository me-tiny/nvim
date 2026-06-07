local M = {}

local FD = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
local TTL = 5000
local LIMIT = 200

local cache = {}
local warned = false

local function refresh(cwd)
    local e = cache[cwd]
    if e and e.scanning then
        return
    end
    cache[cwd] = e or {}
    cache[cwd].scanning = true
    vim.system(FD, { cwd = cwd, text = true }, function(obj)
        cache[cwd] = {
            files = obj.code == 0 and vim.split(obj.stdout, "\n", { trimempty = true }) or {},
            time = vim.uv.now(),
            scanning = false,
        }
    end)
end

function M.findfunc(cmdarg, cmdcomplete)
    local cwd = vim.fn.getcwd()
    local e = cache[cwd]

    if not e or not e.time then
        local files = vim.fn.systemlist(FD)
        if vim.v.shell_error ~= 0 then
            if not warned then
                warned = true
                vim.schedule(function()
                    vim.notify("findfunc: `fd` failed or not found", vim.log.levels.WARN)
                end)
            end
            return {}
        end
        cache[cwd] = { files = files, time = vim.uv.now(), scanning = false }
        e = cache[cwd]
    elseif vim.uv.now() - e.time > TTL then
        refresh(cwd)
    end

    if cmdarg == "" then
        return vim.list_slice(e.files, 1, LIMIT)
    end

    local matches = vim.fn.matchfuzzy(e.files, cmdarg)
    if cmdcomplete then
        return vim.list_slice(matches, 1, LIMIT)
    end

    return matches[1] and { matches[1] } or {}
end

function M.setup()
    vim.o.findfunc = "v:lua.require'util.find'.findfunc"
    local group = vim.api.nvim_create_augroup("util_find", { clear = true })
    vim.api.nvim_create_autocmd("DirChanged", {
        group = group,
        callback = function()
            refresh(vim.fn.getcwd())
        end,
    })
    vim.api.nvim_create_user_command("FindRefresh", function()
        refresh(vim.fn.getcwd())
    end, {})
    refresh(vim.fn.getcwd())
end

return M
