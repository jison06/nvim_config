-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<Space>w', ':w<CR>', { silent = true })

-- Keymaps for formatting
vim.keymap.set('n', '<leader>ff', ':Format<CR>', { silent = true })
vim.keymap.set('n', '<leader>p', ':Prettier<CR>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- file explorer keymaps
vim.keymap.set('n', '<leader>fe', ':NvimTreeToggle<CR>', { silent = true})
vim.keymap.set('n', '<leader>ntff<CR>', ':NvimTreeFindFile', { silent = true})
vim.keymap.set('n', '<leader>ntc', ':NvimTreeCollapse<CR>', { silent = true})
