-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- run c++ code with tests
vim.api.nvim_set_keymap('n', '<leader>rc', ':w<CR>:sp | terminal bash -c "g++ % -o %:r && ./%:r < input.txt; exec bash"<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>drc', ':!g++ -g -o main main.cpp<CR>', { noremap = true, silent = true })
-- FUNCTIONS
-- erstellen eine Projekts fuer competitive Programming
-- Funktion zum Erstellen des Ordners und der Dateien
function CreateCppProject()
  local project_name = vim.fn.input 'Projektname: '

  -- Ordner erstellen
  vim.fn.mkdir(project_name, 'p')

  -- C++-Datei mit Boilerplate-Code erstellen
  local cpp_file = project_name .. '/' .. 'main' .. '.cpp'
  local cpp_boilerplate = [[
#include <bits/stdc++.h>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
]]
  vim.fn.writefile(vim.split(cpp_boilerplate, '\n'), cpp_file)

  -- Leere Textdatei erstellen
  local txt_file = project_name .. '/input.txt'
  vim.fn.writefile({}, txt_file)

  -- Dateien im Editor öffnen
  vim.cmd('edit ' .. cpp_file)
  vim.cmd('vsplit ' .. txt_file)
end

-- Tastenkombination zum Erstellen eines neuen Projekts
vim.api.nvim_set_keymap('n', '<leader>np', ':lua CreateCppProject()<CR>', { noremap = true, silent = true })
