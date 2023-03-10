-- bootstrap package manager if not installed
local packpath = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(packpath)) > 0 then
    IS_NEW_INSTALL = vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packpath
    })
    print('Installing packer. Close and reopen Neovim...')
    vim.cmd.packadd('packer.nvim')
end

local packer_installed, packer = pcall(require, 'packer')
if not packer_installed then return end

-- TODO: use snapshots with Packer for better safety and stability.
return packer.startup(function(use)
    use 'wbthomason/packer.nvim' -- plugin manager
    use 'lewis6991/impatient.nvim' -- cache lua modules for fast startup
    use 'nvim-lua/popup.nvim' -- ui utils
    use 'nvim-lua/plenary.nvim' -- lua/vim utils
    use 'rebelot/kanagawa.nvim' -- colorscheme
    use 'NvChad/nvim-colorizer.lua' -- highlights colors (e.g. red, #ffffff)
    use 'nvim-tree/nvim-tree.lua' -- filetree window
    use 'nvim-telescope/telescope.nvim' -- fuzzy finder
    use 'nvim-telescope/telescope-fzy-native.nvim' -- faster sorting for fuzzy finder
    use 'kevinhwang91/nvim-bqf' -- better quickfix list
    use 'ggandor/leap.nvim' -- 's' or 'S' for instant 2-char search
    use { 'kylechui/nvim-surround', tag = '*' } -- commands to surround code with paired chars like [], {}, etc
    use 'numToStr/Comment.nvim' -- commands to comment out codes
    use 'windwp/nvim-autopairs' -- auto-close paired chars like "", (), etc
    use 'Darazaki/indent-o-matic' -- simple algo to auto-detect indent settings in existing files
    use 'nvim-treesitter/nvim-treesitter' -- parses code to AST. Syntax highlighting and more
    use 'RRethy/nvim-treesitter-textsubjects' -- use AST to guess current context for selecting and editing code.
    use 'nvim-treesitter/nvim-treesitter-textobjects' -- use AST to select/edit treesitter queries (e.g. `vif` to select in function)
    use 'tpope/vim-fugitive' -- git integration by The Pope
    use 'tpope/vim-rhubarb' -- :Gbrowse to open file or selection in GitHub
    use 'lewis6991/gitsigns.nvim' -- view and act on Git Diffs
    use 'williamboman/mason.nvim' -- manage installing language servers, debuggers, and more
    use 'jose-elias-alvarez/null-ls.nvim' -- integrate linters, formatters, and more with Nvim LSP client
    use 'jayp0521/mason-null-ls.nvim' -- manage installing null-ls sources
    use 'neovim/nvim-lspconfig' -- configure language servers
    use 'williamboman/mason-lspconfig.nvim' -- integrate mason with lspconfig; install all configured servers
    use 'jose-elias-alvarez/typescript.nvim' -- typescript-specific features like organize imports and etc
    use 'b0o/schemastore.nvim' -- access schema info for common JSON files; package.json and etc.
    use 'hrsh7th/nvim-cmp' -- completion framework, not including completion sources
    use 'hrsh7th/cmp-nvim-lsp' -- use Nvim LSP as completion source
    use 'hrsh7th/cmp-buffer' -- completion from text in buffer
    use 'hrsh7th/cmp-path' -- completion from file/directory paths
    use 'hrsh7th/cmp-nvim-lsp-signature-help' -- use completion UI to show signature help
    use 'hrsh7th/cmp-cmdline' -- completion from Vim/system commands in cmdline
    use 'L3MON4D3/LuaSnip' -- snippet engine is required for nvim-cmp framework; no snippets installed

    -- run PackerSync if packer has just been bootstrapped
    if IS_NEW_INSTALL then require('packer').sync() end
end)
