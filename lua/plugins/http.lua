return {
  "mistweaverco/kulala.nvim",
  -- 只有在打开 http/rest 文件时才会加载这些快捷键
  keys = {
    {
      "<leader>Rs",
      function()
        require("kulala").run()
      end,
      desc = "Send request",
      ft = { "http", "rest" },
    },
    {
      "<leader>Ra",
      function()
        require("kulala").run_all()
      end,
      desc = "Send all requests",
      ft = { "http", "rest" },
    },
    {
      "<leader>Rb",
      function()
        require("kulala").scratchpad()
      end,
      desc = "Open scratchpad",
      ft = { "http", "rest" },
    },
    {
      "[R",
      function()
        require("kulala").jump_prev()
      end,
      desc = "Jump to prev request",
      ft = { "http", "rest" },
    },
    {
      "]R",
      function()
        require("kulala").jump_next()
      end,
      desc = "Jump to next request",
      ft = { "http", "rest" },
    },
  },
  opts = {
    -- 既然你在 keys 里手动定义了，建议保持这两个为 false 避免冲突
    global_keymaps = false,
    -- 如果想在结果窗口看到图标，可以开启以下配置
    winbar = true,
    default_view = "body",
  },
}
