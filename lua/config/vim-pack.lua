-- stolen directly from https://github.com/MariaSolOs
local M = {}

---@class PluginSpec
---@field src string The GitHub repository of the plugin
---@field version? string|vim.VersionRange Optional branch, tag, commit, or semver range to track
---@field module_name? string Optional module name for configuration (defaults to the repo name)
---@field opts? table|fun():table Optional configuration options for the plugin
---@field on_setup? fun():nil Optional function to run after the plugin is loaded and configured
---@field setup? false Set to false to skip require/setup entirely (for vimscript-only or data-only plugins)
---@field build? fun():nil Optional function to run on every load, before setup

---@param plugins PluginSpec[]
local function configure(plugins)
    local sources = vim.iter(plugins)
        :map(function(plugin)
            return {
                src = string.format("https://github.com/%s", plugin.src),
                version = plugin.version,
            }
        end)
        :totable()
    vim.pack.add(sources)

    for _, plugin in ipairs(plugins) do
        if plugin.build then
            plugin.build()
        end
        if plugin.setup ~= false then
            local module_name = plugin.module_name or (plugin.src:match(".+/(.+)"):gsub("%.nvim$", ""))
            local mod = require(module_name)
            if type(mod.setup) == "function" then
                local opts = type(plugin.opts) == "function" and plugin.opts() or plugin.opts
                mod.setup(opts or {})
            end
        end
        if plugin.on_setup then
            plugin.on_setup()
        end
    end
end

---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param pattern? string|string[]
---@param plugins PluginSpec[]
local add_on_event = function(event, pattern, plugins)
    vim.api.nvim_create_autocmd(event, {
        pattern = pattern,
        once = true,
        callback = function(args)
            configure(plugins)
            if event == "FileType" then
                vim.api.nvim_exec_autocmds("FileType", { buffer = args.buf, modeline = false })
            end
        end,
    })
end

--- Helper function for adding and configuring plugins eagerly, with no lazy-loading.
---
---@param plugins PluginSpec[]
function M.add(plugins)
    configure(plugins)
end

--- Helper function for adding and configuring plugins to the current session on a specific event.
---
---@param event vim.api.keyset.events|vim.api.keyset.events[]
---@param plugins PluginSpec[]
function M.add_on_event(event, plugins)
    add_on_event(event, nil, plugins)
end

--- Helper function for adding and configuring plugins to the current session when a file of a specific type is first opened.
---
---@param patterns string|string[]
---@param plugins PluginSpec[]
function M.add_on_file_type(patterns, plugins)
    add_on_event("FileType", patterns, plugins)
end

--- Runs the given command inside the plugin's directory when the plugin is updated.
---
---@param plugin_name string Plugin name
---@param cmd string[]|fun(path: string):nil Argv list to run in the plugins's dir, or a function receiving the plugins's path
function M.on_plugin_update(plugin_name, cmd)
    vim.api.nvim_create_autocmd("PackChanged", {
        callback = function(args)
            if args.data.spec.name == plugin_name and (args.data.kind == "install" or args.data.kind == "update") then
                if type(cmd) == "function" then
                    cmd(args.data.path)
                else
                    vim.system(cmd, { cwd = args.data.path })
                end
            end
        end,
    })
end

return M
