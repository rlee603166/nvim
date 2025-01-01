-- Initialize mason
require("mason").setup()

-- Initialize mason-lspconfig
require("mason-lspconfig").setup({
    ensure_installed = { 
        "eslint",     -- For JavaScript/TypeScript
        "html",
        "cssls",
        "emmet_ls",
        "tailwindcss"  -- Optional: If you use Tailwind
    },
    automatic_installation = true,
})

-- Set up LSP configurations
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- HTML
lspconfig.html.setup({
    capabilities = capabilities,
    filetypes = { "html", "javascriptreact", "jsx", "tsx" }
})

-- ESLint for TypeScript/JavaScript
lspconfig.eslint.setup({
    capabilities = capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
})

-- CSS
lspconfig.cssls.setup({
    capabilities = capabilities,
})

-- Emmet
lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { 
        "html", "typescriptreact", "javascriptreact", 
        "css", "sass", "scss", "less", "jsx", "tsx" 
    },
})

-- Optional: Tailwind CSS
lspconfig.tailwindcss.setup({
    capabilities = capabilities,
})

-- Configure completion
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Optional: Set up keybindings for LSP functionality
local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
