-- Lualine statusline with catppuccin theme
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local function lsp_clients()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return ""
      end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return " " .. table.concat(names, ", ")
    end

    local function macro_recording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end
      return "Recording @" .. reg
    end

    require("lualine").setup({
      options = {
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true, -- single statusline for all windows
        disabled_filetypes = {
          statusline = { "alpha", "NvimTree", "lazy", "mason" },
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
          },
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", hint = "󰠠 ", info = " " },
          },
        },
        lualine_c = {
          { "filename", path = 1 }, -- relative path
          { macro_recording, color = { fg = "#f38ba8" } },
        },
        lualine_x = {
          { lsp_clients, color = { fg = "#a6e3a1" } },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { "nvim-tree", "toggleterm", "trouble", "lazy" },
    })
  end,
}
