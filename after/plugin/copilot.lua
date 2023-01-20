vim.g.copilot_no_tab_map = true
require("copilot").setup({
  panel = { enabled = true },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = "<C-J>",
      decline = "<C-Esc>",
      next = "<C-.>",
      prev = "<C->>",
      dismiss = "<C-Esc>",
    },
  },
})

-- setup copilot_cmp
require("copilot_cmp").setup({
  method = "getCompletionsCycling",
})
