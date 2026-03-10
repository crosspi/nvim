-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>fF", function()
  Snacks.terminal.open(nil, { win = { width = 0.9, height = 0.9 } })
end, { desc = "Big Terminal" })
