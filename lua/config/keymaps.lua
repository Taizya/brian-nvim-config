local keymap = vim.keymap
local opt = vim.opt

opt.hlsearch = true
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<C-e>', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keymap.set('n', '<C-q>', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap.set('v', '<', '<gv', {})
keymap.set('v', '>', '>gv', {})

keymap.set('n', '<leader>msg', '<cmd>messages<CR>', {})

keymap.set('n', '<leader>p', ':bp<CR>', {})
keymap.set('n', '<leader>n', ':bn<CR>', {})

keymap.set('n', '<leader>sv', ':vsplit<CR>', {})
keymap.set('n', '<leader>sh', ':split<CR>', {})

keymap.set('n', '<C-h>', '<C-w>h', {})
keymap.set('n', '<C-j>', '<C-w>j', {})
keymap.set('n', '<C-k>', '<C-w>k', {})
keymap.set('n', '<C-l>', '<C-w>l', {})

vim.api.nvim_set_keymap('n', '<leader>cc', 'gcc', {})
vim.api.nvim_set_keymap('v', '<leader>cc', 'gcc', {})

keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>fc', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

