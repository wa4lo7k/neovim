-- LSP Configuration
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",          -- ESLint
          "html",            -- HTML
          "cssls",           -- CSS
          "tailwindcss",     -- Tailwind CSS
          "jsonls",          -- JSON
          "lua_ls",          -- Lua
          "clangd",          -- C/C++
          "sqlls",           -- SQL
          "graphql",         -- GraphQL
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local keymap = vim.keymap

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Setup LSP servers using vim.lsp.config
      local servers = {
        eslint = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = {
                  [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                  [vim.fn.stdpath("config") .. "/lua"] = true,
                },
              },
            },
          },
        },
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders=true",
          },
        },
        sqlls = {},
        graphql = {
          -- Only enable if graphql-config is present
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(".graphqlrc*", ".graphql.config.*", "graphql.config.*")(fname)
          end,
        },
      }

      -- Use the new vim.lsp.config API if available, fallback to lspconfig
      local has_new_api = vim.fn.has("nvim-0.11") == 1
      
      if has_new_api then
        for server, config in pairs(servers) do
          config.capabilities = capabilities
          config.on_attach = on_attach
          vim.lsp.config[server] = config
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
              vim.lsp.enable(server)
            end,
          })
        end
      else
        -- Fallback to lspconfig for older Neovim versions
        local lspconfig = require("lspconfig")
        for server, config in pairs(servers) do
          config.capabilities = capabilities
          config.on_attach = on_attach
          lspconfig[server].setup(config)
        end
      end
    end,
  },
}
