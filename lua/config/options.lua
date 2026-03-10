-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local is_termux = os.getenv("TERMUX_VERSION") ~= nil

-- =========================================================
-- 1. 移动端/小屏幕显示优化 (Mobile UI Improvements)
-- =========================================================
if is_termux then
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
-- ~/.config/nvim/lua/config/options.lua
else
if vim.g.neovide then
  -- 1. FONT SETTINGS
  -- Ensure this font is installed on WINDOWS, not just WSL.
  -- Syntax: "FontName:hSize"
  vim.o.guifont = "FiraCode Nerd Font Mono:h14"
  -- 2. WINDOW SETTINGS
  vim.g.neovide_opacity = 0.95 -- 0.0 to 1.0
  vim.g.neovide_window_blurred = true -- Turn on blur (glass effect)
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- 3. ANIMATION SETTINGS
  -- Decrease these for faster performance, increase for smoothness
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_hide_mouse_when_typing = true

  -- 4. BEHAVIOR
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_fullscreen = true
  vim.g.neovide_remember_window_size = true
end
vim.opt.clipboard = { "unnamed", "unnamedplus" }

-- WSL 剪贴板配置：使用 Windows 原生工具
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
end
