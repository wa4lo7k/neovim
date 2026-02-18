-- Fix for Telescope on Neovim 0.11+
if vim.fn.has("nvim-0.11") == 1 then
  vim.treesitter.language.ft_to_lang = function(ft)
    local success, result = pcall(vim.treesitter.get_lang, ft)
    return success and result or ft
  end
end

-- Ultimate Neovim Setup for Web Development & C++
-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key (must be set before lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core settings (load before plugins for correct behavior)
require("config.options")

-- Load plugins
require("lazy").setup("plugins", {
  defaults = {
    lazy = false, -- plugins load at startup unless they specify lazy loading
    version = false, -- always use latest git commit
  },
  install = {
    missing = true,
    colorscheme = { "catppuccin", "habamax" },
  },
  checker = {
    enabled = true,  -- auto-check for plugin updates
    notify = false,  -- don't notify on startup
    frequency = 3600, -- check every hour
  },
  change_detection = {
    enabled = true,
    notify = false, -- don't notify on config change
  },
  performance = {
    rtp = {
      -- Disable unused built-in plugins for faster startup
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",
    size = { width = 0.8, height = 0.8 },
  },
})

-- Keymaps and autocmds (load after plugins)
require("config.keymaps")
require("config.autocmds")
