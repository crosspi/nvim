-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local is_termux = os.getenv("TERMUX_VERSION") ~= nil

-- =========================================================
-- 通用选项 (All Platforms)
-- =========================================================
vim.opt.smoothscroll = true -- 平滑滚动 (Neovim 0.10+)

-- =========================================================
-- Termux 移动端优化
-- =========================================================
if is_termux then
  vim.opt.wrap = true -- 自动换行
  vim.opt.linebreak = true -- 智能换行，不截断单词
  vim.opt.breakindent = true -- 换行缩进保持一致
  vim.opt.textwidth = 0 -- 禁用强制硬换行
  vim.opt.relativenumber = false -- 关闭相对行号
  vim.opt.number = true -- 仅保留绝对行号

  -- 节省水平空间
  vim.opt.foldcolumn = "0"
  vim.opt.signcolumn = "yes:1"
  vim.opt.scrolloff = 5
  vim.opt.sidescrolloff = 5

  -- 诊断信息：手机屏幕窄，关闭行内显示
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  -- 剪切板设置 (Proot ArchLinux)
  vim.opt.clipboard = "unnamedplus"
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

  -- 性能微调
  vim.opt.timeoutlen = 500
  vim.opt.updatetime = 250
  vim.opt.mouse = "a"

-- =========================================================
-- 桌面端设置 (NixOS / Neovide / WSL)
-- =========================================================
else
  -- Neovide GUI 设置
  if vim.g.neovide then
    vim.o.guifont = "Maple Mono Normal NF CN:h14"
    vim.g.neovide_opacity = 0.8
    vim.g.neovide_window_blurred = true
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_fullscreen = true
    vim.g.neovide_remember_window_size = true
  end

  -- WSL 剪贴板
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
