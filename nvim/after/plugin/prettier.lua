local null_ls = require("null-ls")
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre"
local async = event == "BufWritePost"

null_ls.setup{
    sources = {
        null_ls.builtins.formatting.prettier.with({
            filetypes = {
                "javascript",
                "javascriptreact",
                "typescript",
                "typescriptreact",
            },
            extra_args = {
                "--tab-width", "4",
                "--print-width", "100",
                "--single-quote", "false",
                "--trailing-comma", "es5",
                "--bracket-spacing", "true",
                "--jsx-bracket-same-line", "false",
                "--arrow-parens", "avoid",
                "--end-of-line", "lf"
            }
        })
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
                vim.lsp.buf.format({ 
                    bufnr = vim.api.nvim_get_current_buf(),
                    filter = function(c) 
                        return c.name == "null-ls" 
                    end
                })
            end, { buffer = bufnr, desc = "[lsp] format" })
        end
    end
}
