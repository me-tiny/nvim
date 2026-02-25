---@type vim.lsp.Config
return {
    cmd = {
        "clangd",
        "-j=" .. vim.uv.available_parallelism(), -- cpu cores
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders=false",
        "--fallback-style={BasedOnStyle: LLVM, AllowShortFunctionsOnASingleLine: None}",
    },
    filetypes = {
        "c",
        "cpp",
    },
    init_options = {
        fallbackFlags = {
            "--std=c++23",
            "-Wall",
            "-Weffc++",
            "-Wextra",
            "-Wconversion",
            "-Wsign-conversion",
            "-Werror",
        },
    },
    on_attach = function()
        local clangd_extensions_source_header = require("clangd_extensions.switch_source_header")
        vim.keymap.set(
            "n",
            "<Leader>ch",
            clangd_extensions_source_header.switch_source_header,
            { desc = "Switch source/header (C/C++)", silent = true }
        )
    end,
}
