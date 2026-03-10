-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- ~/.config/nvim/lua/config/options.lua

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
