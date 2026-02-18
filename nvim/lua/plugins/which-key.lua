-- Which-key for keybinding hints
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- Use the new which-key v3 config format
    preset = "modern",
    delay = 500,
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
      ellipsis = "…",
      mappings = true,
      rules = {},
      colors = true,
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      wo = {
        winblend = 0,
      },
    },
    layout = {
      width = { min = 20 },
      spacing = 3,
    },
    spec = {
      -- Group labels for better organization
      { "<leader>f", group = "Find/Telescope" },
      { "<leader>e", group = "Explorer" },
      { "<leader>s", group = "Split" },
      { "<leader>t", group = "Tab/Toggle" },
      { "<leader>b", group = "Buffer" },
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Rename/Restart" },
      { "<leader>d", group = "Debug" },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>x", group = "Trouble/Diagnostics" },
      { "<leader>m", group = "Format" },
    },
  },
}
