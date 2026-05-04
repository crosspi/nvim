return {
  -- tokyonight 透明背景
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  -- catppuccin 透明背景 (如果有使用)
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
    },
  },
}
