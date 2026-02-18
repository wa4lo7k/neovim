# Ultimate Neovim Setup for Web & Mobile Development + C++

A comprehensive Neovim configuration optimized for modern web development (React, Next.js, Node.js), mobile app development (React Native), backend services (Supabase, PostgreSQL, MySQL), and C++ development.

![Dashboard](./screenshot1.png)
![Editor View](./screenshot.png)

## Features

- **LSP Support**: Full language server protocol support for TypeScript, JavaScript, HTML, CSS, Lua, C++, SQL, and GraphQL
- **Autocompletion**: Intelligent code completion with nvim-cmp
- **Syntax Highlighting**: Tree-sitter powered syntax highlighting
- **File Explorer**: nvim-tree for file navigation
- **Fuzzy Finder**: Telescope for fast file and text searching
- **Git Integration**: Gitsigns for git status in the gutter
- **Debugging**: DAP support for JavaScript/TypeScript and C++
- **Formatting**: Auto-formatting with Prettier, Stylua, and clang-format
- **React/React Native Tools**: Component extraction and TypeScript enhancements
- **Terminal**: Integrated floating terminal with toggleterm
- **Beautiful UI**: Catppuccin theme, lualine statusline, and bufferline

## Prerequisites

### For Arch Linux

```bash
# Essential tools
sudo pacman -S neovim git nodejs npm ripgrep fd clang cmake

# Optional but recommended
sudo pacman -S python-pip

# For React Native development (optional)
yay -S android-studio  # or install from AUR
```

### For Debian/Ubuntu

```bash
# Node.js (for JavaScript/TypeScript LSP)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Build essentials (for C++ and native modules)
sudo apt-get install build-essential cmake

# Ripgrep (for Telescope live grep)
sudo apt-get install ripgrep

# fd (for Telescope file finder)
sudo apt-get install fd-find

# Clang (for C++ development)
sudo apt-get install clang clangd

# Git
sudo apt-get install git
```

## Installation

### Step 1: Backup Existing Config (if any)
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

### Step 2: Create Neovim Config Directory
```bash
mkdir -p ~/.config/nvim
```

### Step 3: Copy Configuration Files

If you're in the directory with these files:
```bash
cp -r * ~/.config/nvim/
```

Or create the structure manually:
```
~/.config/nvim/
├── init.lua
├── lua/
│   ├── config/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   └── autocmds.lua
│   └── plugins/
│       └── (all plugin files)
└── README.md
```

### Step 4: Start Neovim
```bash
nvim
```

Wait for plugins to install automatically via lazy.nvim (this may take 1-2 minutes on first launch).

### Step 5: Restart Neovim
Close and reopen Neovim after initial plugin installation.

### Step 6: Install Language Servers
```vim
:Mason
```

Then install these tools from Mason:
- `eslint-lsp` (eslint)
- `html-lsp` (html)
- `css-lsp` (cssls)
- `tailwindcss-language-server` (tailwindcss)
- `json-lsp` (jsonls)
- `lua-language-server` (lua_ls)
- `clangd` (C++)
- `sqlls` (SQL)
- `graphql-language-service-cli` (graphql)
- `prettier` (formatter)
- `stylua` (Lua formatter)
- `clang-format` (C++ formatter)
- `js-debug-adapter` (JavaScript debugger)

## Key Mappings

Leader key: `Space`

### General
- `jk` - Exit insert mode
- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>nh` - Clear search highlights

### File Explorer (nvim-tree)
- `<leader>ee` - Toggle file explorer
- `<leader>ef` - Toggle file explorer on current file
- `<leader>ec` - Collapse file explorer
- `<leader>er` - Refresh file explorer

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files
- `<leader>fr` - Find recent files
- `<leader>fs` - Find string in project
- `<leader>fc` - Find string under cursor
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help

### LSP
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gt` - Go to type definition
- `gR` - Show references
- `K` - Show hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>d` - Show line diagnostics
- `<leader>D` - Show buffer diagnostics
- `[d` - Previous diagnostic
- `]d` - Next diagnostic

### React/React Native
- TypeScript/JavaScript support via typescript-tools.nvim (replaces deprecated ts_ls)

### Debugging
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>du` - Toggle debug UI
- `<leader>dt` - Terminate debug session

### Git
- `]c` - Next git hunk
- `[c` - Previous git hunk
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hp` - Preview hunk
- `<leader>hb` - Blame line

### Window Management
- `<leader>sv` - Split vertically
- `<leader>sh` - Split horizontally
- `<leader>se` - Make splits equal
- `<leader>sx` - Close split
- `<C-h/j/k/l>` - Navigate between windows

### Buffer Navigation
- `<S-h>` - Previous buffer
- `<S-l>` - Next buffer
- `<leader>bd` - Delete buffer

### Terminal
- `<C-\>` - Toggle floating terminal
- `<Esc>` or `jk` - Exit terminal mode

### Trouble (Diagnostics)
- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Toggle buffer diagnostics

## Project Structure

```
.
├── init.lua                          # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua              # Neovim options
│   │   ├── keymaps.lua              # Key mappings
│   │   └── autocmds.lua             # Auto commands
│   └── plugins/
│       ├── colorscheme.lua          # Catppuccin theme
│       ├── treesitter.lua           # Syntax highlighting
│       ├── lsp.lua                  # LSP configuration
│       ├── completion.lua           # Autocompletion
│       ├── formatting.lua           # Code formatting
│       ├── telescope.lua            # Fuzzy finder
│       ├── nvim-tree.lua            # File explorer
│       ├── bufferline.lua           # Buffer tabs
│       ├── lualine.lua              # Statusline
│       ├── gitsigns.lua             # Git integration
│       ├── dap.lua                  # Debugging
│       ├── autopairs.lua            # Auto pairs
│       ├── comment.lua              # Commenting
│       ├── which-key.lua            # Keybinding hints
│       ├── indent-blankline.lua     # Indent guides
│       ├── todo-comments.lua        # TODO highlights
│       ├── trouble.lua              # Diagnostics list
│       ├── alpha.lua                # Dashboard
│       ├── toggleterm.lua           # Terminal
│       ├── surround.lua             # Surround text
│       ├── colorizer.lua            # Color highlighter
│       └── react-native.lua         # React/React Native tools
└── README.md                        # This file
```

## Customization

- **Change theme**: Edit `lua/plugins/colorscheme.lua`
- **Modify keymaps**: Edit `lua/config/keymaps.lua`
- **Add LSP servers**: Edit `lua/plugins/lsp.lua`
- **Configure formatters**: Edit `lua/plugins/formatting.lua`

## Tips

1. Use `:checkhealth` to diagnose issues
2. Use `:Lazy` to manage plugins
3. Use `:Mason` to manage LSP servers and tools
4. Use `:LspInfo` to check LSP status
5. Use `:Telescope keymaps` to see all keymaps

## Troubleshooting

If you encounter issues:

1. Run `:checkhealth` to identify problems
2. Ensure all prerequisites are installed
3. Run `:Lazy sync` to update plugins
4. Run `:Mason` to verify LSP installations
5. Check `:LspInfo` for LSP connection status

## Tech Stack Support

### Web Development
- **React**: Full TypeScript/JavaScript support with JSX/TSX
- **Next.js**: TypeScript/JavaScript with React support
- **Node.js**: JavaScript/TypeScript LSP and debugging
- **HTML/CSS**: Full LSP support with Emmet
- **Tailwind CSS**: IntelliSense and autocompletion

### Mobile App Development
- **React Native**: Full TypeScript/JavaScript support with JSX/TSX
- **Expo**: JavaScript/TypeScript support
- **Native modules**: C++ support for native development

### Backend & Database
- **Supabase**: JavaScript/TypeScript client support
- **PostgreSQL/MySQL**: SQL LSP and syntax highlighting
- **GraphQL**: Schema and query support
- **REST APIs**: JSON and HTTP support

### Systems Programming
- **C++**: clangd LSP, debugging, and formatting
- **C**: Full LSP support with clangd

Enjoy your ultimate Neovim setup!
