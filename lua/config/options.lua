-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- =========================================================
-- 1. 移动端/小屏幕显示优化 (Mobile UI Improvements)
-- =========================================================
vim.opt.wrap = true -- 自动换行，避免代码跑到屏幕外
vim.opt.linebreak = true -- 智能换行，不会把单词截断
vim.opt.breakindent = true -- 换行后的缩进保持一致
vim.opt.textwidth = 0 -- 禁用强制硬换行
vim.opt.relativenumber = false -- 关闭相对行号 (手机滚动时相对行号跳动会晕，且消耗性能)
vim.opt.number = true -- 仅保留绝对行号

-- 节省水平空间
vim.opt.foldcolumn = "0" -- 隐藏折叠栏，节省左侧宽度
vim.opt.signcolumn = "yes:1" -- 缩减左侧图标栏（Git/LSP图标）的宽度
vim.opt.scrolloff = 5 -- 光标距离顶部/底部保留 5 行 (触摸屏上比默认的 8 行更节省空间)
vim.opt.sidescrolloff = 5 -- 水平滚动保留余量

-- =========================================================
-- 2. 诊断信息显示优化 (Diagnostics)
-- =========================================================
-- 手机屏幕窄，行内显示错误信息(virtual_text)会挤占代码空间
-- 建议使用悬浮窗或点击查看，或者使用 virtual_lines (需插件支持)
vim.diagnostic.config({
  virtual_text = false, -- 关闭行内错误提示
  -- 如果你安装了 lsp_lines.nvim 插件，可以使用 virtual_lines
  -- 如果没有，建议设置为 false，通过 <leader>d 查看详细错误
  virtual_lines = false,
  underline = true,
  update_in_insert = false, -- 输入时不更新诊断，提升手机性能
  severity_sort = true,
})

-- =========================================================
-- 3. 剪切板设置 (Clipboard - Proot ArchLinux 特别优化)
-- =========================================================
-- Clipboard settings
vim.opt.clipboard = "unnamedplus"
-- 设置剪切板与系统同步
-- 告诉 Neovim 如何使用 Termux 的剪切板工具
-- 注意：这里使用绝对路径，指向宿主 Termux 的工具
vim.g.clipboard = {
  name = "termux",
  copy = {
    ["+"] = "/data/data/com.termux/files/usr/bin/termux-clipboard-set",
    ["*"] = "/data/data/com.termux/files/usr/bin/termux-clipboard-set",
  },
  paste = {
    ["+"] = "/data/data/com.termux/files/usr/bin/termux-clipboard-get",
    ["*"] = "/data/data/com.termux/files/usr/bin/termux-clipboard-get",
  },
  cache_enabled = 0,
}

-- =========================================================
-- 4. 性能与交互微调 (Performance & Interaction)
-- =========================================================
-- 手机软键盘输入组合键可能有延迟，适当增加超时时间
vim.opt.timeoutlen = 500
vim.opt.updatetime = 250 -- 加快 CursorHold 事件触发（用于高亮当前词等）

-- 确保鼠标/触摸支持开启
vim.opt.mouse = "a"
