local opts = { noremap = true, silent = true }

-- window keymaps
vim.keymap.set('n', '<C-h>', function() vim.cmd.wincmd('h') end, opts)
vim.keymap.set('n', '<C-j>', function() vim.cmd.wincmd('j') end, opts)
vim.keymap.set('n', '<C-k>', function() vim.cmd.wincmd('k') end, opts)
vim.keymap.set('n', '<C-l>', function() vim.cmd.wincmd('l') end, opts)
vim.keymap.set('n', '<C-z>', function() vim.cmd.wincmd('o') end, opts)

-- quickfix list keymaps
vim.keymap.set('n', '<leader>j', vim.cmd.cnext, opts)
vim.keymap.set('n', '<leader>k', vim.cmd.cprev, opts)
vim.keymap.set('n', '<leader>l', vim.cmd.copen, opts)

-- save all
vim.keymap.set('n', '<C-s>', vim.cmd.wa, opts)

-- close file (closes all windows)
vim.keymap.set('n', 'q', vim.cmd.bdelete, opts)

-- close all buffers and windows except for focused window
-- TODO: this could work better; write in lua and make resilient
vim.keymap.set('n', '<c-q>', function() vim.cmd('%bd|e#|bd#') end, opts)

-- use 'm' to record and replay macros
vim.keymap.set('n', 'm', 'q', opts)
vim.keymap.set('n', 'M', 'Q', opts)

-- save deleted text in named 'd' register instead of system clipboard
vim.keymap.set({ 'n', 'v' }, 'd', '"dd', opts)
vim.keymap.set('n', 'dd', '"ddd', opts)
vim.keymap.set('n', 'D', '"dD', opts)
vim.keymap.set({ 'n', 'v' }, 'c', '"dc', opts)
vim.keymap.set('n', 'cc', '"dcc', opts)
vim.keymap.set('n', 'C', '"dC', opts)

-- don't overwrite any registers when pasting in visual mode
vim.keymap.set('v', 'p', '"_dP', opts)

-- <spacebar><enter> to quit neovim
vim.keymap.set('n', '<leader><CR>', vim.cmd.qall, opts)
