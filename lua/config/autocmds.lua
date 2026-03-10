-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 高亮 yank 的文本
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- 自动调整窗口大小（Termux 小屏幕优化）
if os.getenv("TERMUX_VERSION") ~= nil then
  vim.api.nvim_create_autocmd("VimResized", {
    desc = "Auto resize windows on Termux",
    callback = function()
      vim.cmd("wincmd =")
    end,
  })
end

-- 创建目录（如果不存在）
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Create parent directories on save",
  group = vim.api.nvim_create_augroup("create-parent-dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- 恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Restore cursor position",
  group = vim.api.nvim_create_augroup("restore-cursor", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 压缩空行
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim trailing whitespace and empty lines at end of file",
  group = vim.api.nvim_create_augroup("trim-whitespace", { clear = true }),
  callback = function(event)
    local file = event.match
    if file:match("^/tmp/") then
      return
    end
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\n\+\%$//e]])
    vim.fn.winrestview(save)
  end,
})

-- 自动格式化（如果配置了 formatter）
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Auto format on save",
  group = vim.api.nvim_create_augroup("auto-format", { clear = true }),
  callback = function(event)
    if vim.g.autoformat == false then
      return
    end
    local buf = event.buf
    if vim.lsp.get_clients({ bufnr = buf })[1] then
      vim.lsp.buf.format({ bufnr = buf })
    end
  end,
})
