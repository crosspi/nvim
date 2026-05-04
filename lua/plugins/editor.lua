-- Editor enhancement plugins
return {
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        multiline = true,
      },
    },
  },

  -- =========================================================
  -- nvim-treesitter: 确保安装常用语言解析器
  -- =========================================================
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "bash",
        "fish",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "rust",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "nix",
        "http",
      })
    end,
  },

  -- =========================================================
  -- 快速跳转增强：flash.nvim 配置覆盖
  -- =========================================================
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        -- 在搜索时启用 flash 标签
        search = { enabled = true },
        -- 在 f/t 跳转时启用
        char = { enabled = true },
      },
    },
  },
}
