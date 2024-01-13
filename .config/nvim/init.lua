--
-- Prepare Lazy VIM
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--
-- Install plugins with Lazy VIM
--
require("lazy").setup({
    {
        -- This will boost startup time
        "dstein64/vim-startuptime",
        -- lazy-load on a command
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
            vim.g.startuptime_tries = 10
        end,
    }, {
        -- This has a bunch of methods that will be useful for NeoVIM
        'nvim-lua/plenary.nvim'
    }, {
        -- This is the Theme Catppuccin
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    }, {
        -- Use NNN as file navigator
        "luukvbaal/nnn.nvim",
        config = function() require("nnn").setup() end
    }, {
        -- This will make Git Greater
        'tpope/vim-fugitive'
    }
})

--
-- My VIM configs
--

-- Fonts & Encoding
vim.o.guifont = "JetBrains Mono:h24"
vim.o.encoding = "utf-8"

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Take indent for new line from previous line
vim.o.autoindent = true -- Same indent as previous line
vim.o.smartindent = true -- Smart insertion of indent in some cases
vim.o.expandtab = true -- Replace <Tab> by spaces
vim.o.softtabstop = 4 -- How many spaces is a <Tab>
vim.o.shiftwidth = 4 -- How many spaces for the >> operation

-- Enable highlight on search
vim.o.hlsearch = true
-- highlight match while typing search pattern
vim.o.incsearch = true

-- Enable break indent
vim.o.breakindent = true

-- Use swapfiles
vim.o.swapfile = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 1000

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.cmd.colorscheme "catppuccin-mocha"

-- Disable intro message
vim.opt.shortmess:append("I")

-- Disable ins-completion-menu messages
vim.opt.shortmess:append("c")

-- Show cursor line and column in the status line
vim.o.ruler = true

-- When scrolling, keep cursor 4 lines away from screen border
vim.o.scrolloff = 8

-- Timeout on leaderkey
vim.o.ttimeout = true
vim.o.ttimeoutlen = 5

-- Right column max chars
vim.opt.colorcolumn = "120"

-- Highlight on yank
-- When doing yank, the yanked text will brifly be highlighted
vim.api.nvim_exec(
[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end
]],
false
)

-- Open file at same location where it was opened last time
vim.cmd(
[[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
)

-- Exclude files and directories using Vim's wildignore
vim.o.wildignore = vim.o.wildignore .. "*/tmp/*,*.so,*.swp,*.zip" -- MacOSX/Linux

-- Set directories for backup/swap/undo files and create them if necessary
local Path = require("plenary.path")

local swapdir = Path:new(Path.path.home .. "/.cache/nvim/swap/")
if not swapdir:exists() then
    swapdir:mkdir()
end
vim.o.directory = tostring(swapdir)

local backupdir = Path:new(Path.path.home .. "/.cache/nvim/backup/")
if not backupdir:exists() then
    backupdir:mkdir()
end
vim.o.backupdir = tostring(backupdir)

local undodir = Path:new(Path.path.home .. "/.cache/nvim/undo/")
if not undodir:exists() then
    undodir:mkdir()
end
vim.o.undodir = tostring(undodir)

-- disable some builtin vim plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

--
-- Keymaps
--
vim.keymap.set("n", "<C-N>", ":NnnPicker %:p:h<CR>")

