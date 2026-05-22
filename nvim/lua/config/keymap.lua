local keymap = vim.keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

keymap.set("n", "<C-h>", "<Cmd>BufferPrevious<CR>", opts)
keymap.set("n", "<C-l>", "<Cmd>BufferNext<CR>", opts)
keymap.set("n", "<C-x>", "<Cmd>BufferClose<CR>", opts)
