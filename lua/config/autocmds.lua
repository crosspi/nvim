-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- NOTE: The following are handled by LazyVim defaults and should NOT be repeated:
--   - TextYankPost (highlight yank)
--   - BufReadPost (restore cursor position)
--   - Auto-formatting (handled by conform.nvim via LazyVim)

-- =========================================================
-- Termux: 自动调整窗口大小
-- =========================================================
if os.getenv("TERMUX_VERSION") ~= nil then
  vim.api.nvim_create_autocmd("VimResized", {
    desc = "Auto resize windows on Termux",
    group = vim.api.nvim_create_augroup("termux_resize", { clear = true }),
    callback = function()
      vim.cmd("wincmd =")
    end,
  })
end

-- =========================================================
-- 创建父目录（如果不存在）
-- =========================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Create parent directories on save",
  group = vim.api.nvim_create_augroup("create_parent_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return -- skip URLs (oil://, fugitive://, etc.)
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- =========================================================
-- 压缩尾部空白和空行
-- =========================================================
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim trailing whitespace and empty lines at end of file",
  group = vim.api.nvim_create_augroup("trim_whitespace", { clear = true }),
  callback = function(event)
    if event.match:match("^/tmp/") then
      return
    end
    -- Skip if formatting is disabled
    if vim.g.autoformat == false or vim.b[event.buf].autoformat == false then
      return
    end
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.cmd([[%s/\n\+\%$//e]])
    vim.fn.winrestview(save)
  end,
})

-- =========================================================
-- 大文件优化：自动禁用耗性能的功能
-- =========================================================
vim.api.nvim_create_autocmd("BufReadPre", {
  desc = "Disable heavy features for large files",
  group = vim.api.nvim_create_augroup("bigfile_perf", { clear = true }),
  callback = function(event)
    local max_filesize = 1024 * 1024 -- 1 MB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(event.buf))
    if ok and stats and stats.size > max_filesize then
      vim.b[event.buf].minicursorword_disable = true
      vim.cmd("syntax clear")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
    end
  end,
})
