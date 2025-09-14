-- Basic Editor Options

local opt = vim.opt

-- Ensure PATH includes common directories for executables
vim.env.PATH = vim.env.PATH .. ":" .. vim.env.HOME .. "/.volta/bin"
vim.env.PATH = vim.env.PATH .. ":" .. vim.env.HOME .. "/.cargo/bin"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping and text width
opt.wrap = true
opt.textwidth = 80
opt.colorcolumn = "80"
opt.linebreak = true
opt.breakindent = true
opt.formatoptions:append("t")  -- Auto-wrap text using textwidth
opt.formatoptions:append("c")  -- Auto-wrap comments using textwidth

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Italic text support in terminal
vim.g.t_ZH = "\x1b[3m"
vim.g.t_ZR = "\x1b[23m"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard = "unnamedplus"

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Backup and swap
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Misc
opt.hidden = true
opt.mouse = "a"
opt.updatetime = 50
opt.timeoutlen = 500
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"