local opts = { noremap = true }

-- center code while scrolling
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)

-- zz is painful
vim.keymap.set('n', 'm', 'zz', opts)

-- window command keymaps
vim.keymap.set('n', '<C-h>', function() vim.cmd.wincmd('h') end, opts)
vim.keymap.set('n', '<C-j>', function() vim.cmd.wincmd('j') end, opts)
vim.keymap.set('n', '<C-k>', function() vim.cmd.wincmd('k') end, opts)
vim.keymap.set('n', '<C-l>', function() vim.cmd.wincmd('l') end, opts)
vim.keymap.set('n', '<C-z>', function() vim.cmd.wincmd('o') end, opts)

-- quickfix list keymaps
vim.keymap.set('n', '<leader>j', vim.cmd.cnext, opts)
vim.keymap.set('n', '<leader>k', vim.cmd.cprev, opts)
vim.keymap.set('n', '<leader>l', function() vim.cmd('botright copen') end, opts)
vim.keymap.set('n', '<leader>J', vim.cmd.cnewer, opts)
vim.keymap.set('n', '<leader>K', vim.cmd.colder, opts)

-- save and quit
vim.keymap.set('n', '<C-s>', vim.cmd.wa, { noremap = true, silent = true })
vim.keymap.set('n', '<leader><CR>', function() vim.cmd('silent wqa') end, opts)
vim.keymap.set('n', 'q', vim.cmd.bdelete, opts)
vim.keymap.set('n', 'Q', vim.cmd.tabclose, opts)

-- close all buffers and windows except for focused window
-- TODO: this could work better; write in lua and make resilient
vim.keymap.set('n', '<c-q>', function() vim.cmd('%bd|e#|bd!#') end, opts)

-- macros
vim.keymap.set('n', '<C-m>', 'q', opts)
vim.keymap.set('n', '<C-n>', 'Q', opts)

-- put deleted stuff in d register
vim.keymap.set({ 'n', 'v' }, 'd', '"dd', opts)
vim.keymap.set('n', 'dd', '"ddd', opts)
vim.keymap.set('n', 'D', '"dD', opts)
vim.keymap.set({ 'n', 'v' }, 'c', '"dc', opts)
vim.keymap.set('n', 'cc', '"dcc', opts)
vim.keymap.set('n', 'C', '"dC', opts)

-- leader d paste from d register
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"dp', opts)
vim.keymap.set({ 'n', 'v' }, '<leader>D', '"dP', opts)
-- or ctrl d in i mode TODO: paste without leading whitespace
vim.keymap.set('i', '<c-d>', '<c-r>d', opts)

-- don't overwrite any registers when pasting in visual mode
vim.keymap.set('v', 'p', '"_dp', opts)
vim.keymap.set('v', 'P', '"_dP', opts)

-- manually complete full lines from open buffers
vim.keymap.set('i', '<C-l>', '<c-x><c-l>')

-- move visual selection up and down
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', opts)
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', opts)
