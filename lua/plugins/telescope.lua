-- Telescope fuzzy finder
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
    { "<leader>fs", "<cmd>Telescope live_grep<cr>", desc = "Find string in cwd" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      pickers = {
        find_files = {
          previewer = false,
        },
        live_grep = {
          previewer = false,
        },
        grep_string = {
          previewer = false,
        },
      },
    })
  end,
}
