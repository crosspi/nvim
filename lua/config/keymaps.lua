-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- =========================================================
-- 窗口 & 终端
-- =========================================================
map({ "n", "t" }, "<C-\\>", function()
  Snacks.terminal.toggle(nil, {
    win = {
      position = "float",
      width = 0.9,
      height = 0.85,
      border = "rounded",
    },
  })
end, { desc = "Toggle Floating Terminal" })

-- =========================================================
-- 更好的移动体验
-- =========================================================
-- 在换行时使用 j/k 移动到视觉行（而非逻辑行）
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down (visual line)", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up (visual line)", expr = true, silent = true })

-- 快速移动半页并居中
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- 搜索结果居中
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- =========================================================
-- 编辑增强
-- =========================================================
-- 可视模式下移动选中行
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- 在 J (join) 时保持光标位置
map("n", "J", "mzJ`z", { desc = "Join line (keep cursor)" })

-- 粘贴时不覆盖寄存器
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwrite register" })

-- 删除时不影响寄存器
map({ "n", "v" }, "<leader>D", [["_d]], { desc = "Delete without register" })

-- =========================================================
-- 快速操作
-- =========================================================
-- 快速保存
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- 选择全部
map("n", "<leader>sa", "ggVG", { desc = "Select all" })
