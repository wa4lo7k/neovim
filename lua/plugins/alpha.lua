-- Dashboard
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                                     ",
      " ██╗    ██╗ █████╗ ██╗  ██╗██╗      ██████╗ ███████╗██╗  ██╗",
      " ██║    ██║██╔══██╗██║  ██║██║     ██╔═████╗╚════██║██║ ██╔╝",
      " ██║ █╗ ██║███████║███████║██║     ██║██╔██║    ██╔╝█████╔╝ ",
      " ██║███╗██║██╔══██║╚════██║██║     ████╔╝██║   ██╔╝ ██╔═██╗ ",
      " ╚███╔███╔╝██║  ██║     ██║███████╗╚██████╔╝   ██║  ██║  ██╗",
      "  ╚══╝╚══╝ ╚═╝  ╚═╝     ╚═╝╚══════╝ ╚═════╝    ╚═╝  ╚═╝  ╚═╝",
      "                                                     ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("s", "  Find text", ":Telescope live_grep <CR>"),
      dashboard.button("t", "  File tree", ":NvimTreeToggle <CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
      dashboard.button("l", "  Lazy", ":Lazy<CR>"),
      dashboard.button("m", "  Mason", ":Mason<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    local function footer()
      return {
        "",
        "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
        "",
        "                    🚀 Key Shortcuts",
        "",
        "  Leader: <Space>",
        "",
        "  📁 File Explorer          🔍 Fuzzy Finder",
        "  <Space>ee - Toggle tree   <Space>ff - Find files",
        "  <Space>ef - Find file     <Space>fs - Find text",
        "  <Space>ec - Collapse      <Space>fb - Find buffers",
        "",
        "  💻 LSP & Code             🐛 Debugging",
        "  gd - Go to definition     <Space>db - Toggle breakpoint",
        "  K  - Hover docs           <Space>dc - Continue",
        "  <Space>ca - Code actions  <Space>di - Step into",
        "  <Space>rn - Rename        <Space>du - Toggle UI",
        "",
        "  🌿 Git                    ⚡ Terminal",
        "  ]c - Next hunk            <C-\\> - Toggle terminal",
        "  [c - Previous hunk        jk - Exit insert mode",
        "  <Space>hs - Stage hunk",
        "  <Space>hp - Preview hunk",
        "",
        "  📦 Buffers & Windows      🎨 Format",
        "  <S-h> - Previous buffer   <Space>mp - Format file",
        "  <S-l> - Next buffer       Auto-format on save",
        "  <Space>sv - Split vert",
        "  <Space>sh - Split horiz",
        "",
        "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
      }
    end

    dashboard.section.footer.val = footer()

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
