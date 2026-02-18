-- Color highlighter (active fork of NvChad/nvim-colorizer.lua)
return {
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    filetypes = {
      "*", -- enable for all filetypes
      css = { css = true, css_fn = true },
      scss = { css = true, css_fn = true },
      html = { names = true },
      javascript = { names = false },
      typescript = { names = false },
    },
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = true,
      RRGGBBAA = true,
      AARRGGBB = false,
      rgb_fn = true,
      hsl_fn = true,
      css = false,
      css_fn = false,
      mode = "background", -- "foreground" | "background" | "virtualtext"
      tailwind = true, -- highlight tailwind colors
      sass = { enable = true, parsers = { "css" } },
      virtualtext = "■",
      always_update = false,
    },
    buftypes = {},
  },
}
