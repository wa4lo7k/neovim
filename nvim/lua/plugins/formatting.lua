-- Formatting with conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        cpp = { "clang_format" },
        c = { "clang_format" },
        python = { "isort", "black" },
      },
      format_on_save = function(bufnr)
        -- Disable for certain filetypes or large files
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end
        return {
          lsp_format = "fallback", -- use lsp_format instead of deprecated lsp_fallback
          async = false,
          timeout_ms = 1500,
        }
      end,
      -- Notify on format errors
      notify_on_error = true,
    })

    -- Format keymap
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 1500,
      })
    end, { desc = "Format file or range (in visual mode)" })

    -- Show formatter info
    vim.keymap.set("n", "<leader>mf", "<cmd>ConformInfo<CR>", { desc = "Show formatter info" })
  end,
}
