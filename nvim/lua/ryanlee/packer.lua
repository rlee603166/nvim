vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    use 'tpope/vim-surround'
    -- Telescope for fuzzy searching
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'rktjmp/lush.nvim' } 
    use { 'rockyzhang24/arctic.nvim', branch = 'v2' }

    -- Treesitter for syntax highlighting
    -- f
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')

    use 'christoomey/vim-tmux-navigator'

    -- Harpoon for project navigation
    use('theprimeagen/harpoon')
    
    -- Undo Tree for better undo history
    use('mbbill/undotree')
    
    -- Git integration with Fugitive
    use('tpope/vim-fugitive')
    
    -- Completion and LSP
    use {'hrsh7th/nvim-cmp'}                    -- Completion engine
    use {'hrsh7th/cmp-nvim-lsp'}               -- LSP completion source
    use {'hrsh7th/cmp-buffer'}                 -- Buffer completion source
    use {'hrsh7th/cmp-path'}                   -- Path completion source
    use {'saadparwaiz1/cmp_luasnip'}          -- Snippet completion source
    
    -- Snippets
    use {'L3MON4D3/LuaSnip'}                   -- Snippet engine
    use {'rafamadriz/friendly-snippets'}       -- Useful snippets collection
    
    -- LSP configuration and setup
    use {'williamboman/mason.nvim'}            -- LSP installer
    use {'williamboman/mason-lspconfig.nvim'}  -- Mason LSP Config
    use('neovim/nvim-lspconfig')
    use('jose-elias-alvarez/null-ls.nvim')
    use('MunifTanjim/prettier.nvim')   

    use 'windwp/nvim-ts-autotag'

    -- Autopairs for automatic pair insertion
    use {
        'windwp/nvim-autopairs',
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
end)
