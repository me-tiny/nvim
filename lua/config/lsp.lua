vim.g.inlay_hints = false
vim.g.codelens = false

vim.lsp.config("*", {
    capabilities = {
        textDocument = {
            semanticTokens = { multilineTokenSupport = true },
        },
    },
})

local servers = vim.iter(vim.api.nvim_get_runtime_file("lsp/*.lua", true))
    :map(function(file)
        return vim.fn.fnamemodify(file, ":t:r")
    end)
    :totable()
vim.lsp.enable(servers)

local function on_attach(client, bufnr)
    local function map(keys, func, desc, mode)
        vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = desc })
    end

    map("grr", Snacks.picker.lsp_references, "References")
    map("gri", Snacks.picker.lsp_implementations, "Implementations")
    map("grd", Snacks.picker.lsp_definitions, "Definitions")
    map("grD", Snacks.picker.lsp_declarations, "Declarations")
    map("gO", Snacks.picker.lsp_symbols, "Document Symbols")
    map("gW", Snacks.picker.lsp_workspace_symbols, "Workspace Symbols")
    map("grt", Snacks.picker.lsp_type_definitions, "Type Definitions")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code Action")
    map("grx", vim.lsp.codelens.run, "Codelens Run")

    if client:supports_method("textDocument/documentHighlight") then
        local group = vim.api.nvim_create_augroup(("lsp-highlight-%d-%d"):format(client.id, bufnr), { clear = true })

        vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
            buf = bufnr,
            group = group,
            callback = vim.lsp.buf.document_highlight,
            desc = "LSP: Highlight references under cursor",
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
            buf = bufnr,
            group = group,
            callback = vim.lsp.buf.clear_references,
            desc = "LSP: Clear highlight references",
        })
    end

    if client:supports_method("textDocument/documentColor") then
        vim.lsp.document_color.enable(true, { bufnr = bufnr })
    end

    if client:supports_method("textDocument/linkedEditingRange") then
        vim.lsp.linked_editing_range.enable(true, { bufnr = bufnr })
    end

    if client:supports_method("textDocument/codeLens") then
        local group = vim.api.nvim_create_augroup(("lsp-codelens-%d-%d"):format(client.id, bufnr), { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
            buf = bufnr,
            group = group,
            callback = function()
                if vim.g.codelens then
                    vim.lsp.codelens.enable(vim.g.codelens, { bufnr = bufnr })
                end
            end,
        })

        map("<Leader>tc", function()
            local mode = vim.api.nvim_get_mode().mode
            vim.g.codelens = not vim.g.codelens
            vim.lsp.codelens.enable(vim.g.codelens and (mode == "n" or mode == "v"), { bufnr = bufnr })
        end, "Toggle Codelens")
    end

    if client:supports_method("textDocument/inlayHint") then
        local group = vim.api.nvim_create_augroup(("inlay-hints-%d-%d"):format(client.id, bufnr), { clear = true })

        if vim.g.inlay_hints then
            vim.defer_fn(function()
                local mode = vim.api.nvim_get_mode().mode
                vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr })
            end, 500)
        end

        vim.api.nvim_create_autocmd("InsertEnter", {
            buf = bufnr,
            group = group,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                end
            end,
        })

        vim.api.nvim_create_autocmd("InsertLeave", {
            buf = bufnr,
            group = group,
            callback = function()
                if vim.g.inlay_hints then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end,
        })

        map("<Leader>th", function()
            local mode = vim.api.nvim_get_mode().mode
            vim.g.inlay_hints = not vim.g.inlay_hints
            vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == "n" or mode == "v"), { bufnr = bufnr })
        end, "Toggle Inlay Hints")
    end

    if client:supports_method("textDocument/foldingRange") then
        local win = vim.api.nvim_get_current_win()
        vim.wo[win][0].foldmethod = "expr"
        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        vim.wo[win][0].foldtext = "v:lua.vim.lsp.foldtext()"
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
    desc = "Configure LSP per client",
})

-- NOTE: dynamic lsp capability reg, not sure if i even need it, from :h LspAttach
-- vim.lsp.handlers["client/registerCapability"] = (function(overridden)
--     return function(err, res, ctx)
--         local result = overridden(err, res, ctx)
--         local client = vim.lsp.get_client_by_id(ctx.client_id)
--         if client then
--             for bufnr in pairs(client.attached_buffers) do
--                 on_attach(client, bufnr)
--             end
--         end
--         return result
--     end
-- end)(vim.lsp.handlers["client/registerCapability"])
