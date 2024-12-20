require('core.functions')

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fe", ":Neotree<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>rf', ':lua run_file_extension()<CR>', { noremap = true, silent = true })

