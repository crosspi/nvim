return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
  keys = {
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
    { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: Select Model" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject Diff" },
  },
}
