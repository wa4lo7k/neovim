-- Debug Adapter Protocol
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim", -- for installing debug adapters
    "jay-babu/mason-nvim-dap.nvim", -- auto-install DAP adapters via Mason
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- mason-nvim-dap: auto-install debug adapters
    require("mason-nvim-dap").setup({
      ensure_installed = {
        "js",       -- JavaScript/TypeScript debugger
        "codelldb", -- C/C++/Rust debugger (replaces cppdbg)
      },
      automatic_installation = true,
      handlers = {}, -- use default handlers
    })

    -- DAP UI setup
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          size = 10,
          position = "bottom",
        },
      },
    })

    -- Virtual text for variable values
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      virt_text_pos = "eol",
    })

    -- JavaScript/TypeScript debugging via vscode-js-debug (installed by mason)
    local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
    if vim.fn.isdirectory(js_debug_path) == 1 then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }
      dap.adapters["pwa-chrome"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_path .. "/js-debug/src/dapDebugServer.js", "${port}" },
        },
      }

      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file (Node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to Node process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
          },
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
            sourceMaps = true,
          },
        }
      end
    end

    -- C/C++ debugging via codelldb (installed by mason)
    local codelldb_path = vim.fn.stdpath("data") .. "/mason/bin/codelldb"
    if vim.fn.executable(codelldb_path) == 1 then
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch (codelldb)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp
    end

    -- Auto open/close UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- DAP signs
    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "DapBreakpointCondition" })
    vim.fn.sign_define("DapLogPoint", { text = "🔵", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine" })

    -- Keymaps
    local keymap = vim.keymap
    keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    keymap.set("n", "<leader>dB", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set conditional breakpoint" })
    keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
    keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
    keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle REPL" })
    keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last" })
    keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle UI" })
    keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
    keymap.set("n", "<leader>dh", require("dap.ui.widgets").hover, { desc = "Hover variables" })
  end,
}
