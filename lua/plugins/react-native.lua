-- React Native development tools
return {
  {
    "jose-elias-alvarez/typescript.nvim",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require("typescript").setup({
        server = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      })
    end,
  },
  {
    "David-Kunz/react-extract.nvim",
    config = function()
      require("react-extract").setup()
      vim.keymap.set("v", "<leader>re", require("react-extract").extract_to_new_file, { desc = "Extract React component" })
      vim.keymap.set("v", "<leader>rc", require("react-extract").extract_to_current_file, { desc = "Extract to current file" })
    end,
  },
}
