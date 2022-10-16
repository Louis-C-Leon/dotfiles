local util = require('louis.util')

-- window keymaps
util.ncmd('<C-h>', 'wincmd h')
util.ncmd('<C-j>', 'wincmd j')
util.ncmd('<C-k>', 'wincmd k')
util.ncmd('<C-l>', 'wincmd l')
util.ncmd('<C-z>', 'wincmd o')

-- quickfix list keymaps
util.ncmd('<leader>j', 'cnext')
util.ncmd('<leader>k', 'cprev')
util.ncmd('<leader>d', 'cfdo')
util.ncmd('<leader>l', 'copen')

-- save all
util.ncmd('<C-s>', 'wa')

-- close file (closes all windows)
util.ncmd('q', 'bd')

-- close all buffers and windows except for focused window
-- TODO: this could work better
util.ncmd('<c-q>', '%bd|e#|bd#')

-- use 'm' to record and replay macros
util.nmap('m', 'q')
util.nmap('M', 'Q')

-- save deleted text in named 'd' register instead of system clipboard
util.nmap('d', '"dd')
util.vmap('d', '"dd')
util.nmap('dd', '"ddd')
util.nmap('D', '"dD')
util.nmap('c', '"dc')
util.vmap('c', '"dc')
util.nmap('cc', '"dcc')
util.nmap('C', '"dC')

-- don't overwrite any registers when pasting in visual mode
util.vmap('p', '"_dP')

-- <spacebar><enter> to quit neovim
util.ncmd('<leader><CR>', 'qa')
