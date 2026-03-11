return {
  -- MCP 协议支持（Neovim 作为 MCP 服务器）
  {
    "zaucy/mcp.nvim",
    lazy = true,
    opts = {},
  },

  -- Gemini CLI 深度集成
  {
    "zaucy/gemini.nvim",
    event = "VeryLazy",
    dependencies = { "zaucy/mcp.nvim" },
    opts = {},
  },
}
