-- Standard Vim Compatibility & Settings

-- Leader Key
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- vim.opt.nocompatible = true              -- be iMproved, required 
vim.opt.number = true                    -- set line numbers 
vim.opt.relativenumber = true            -- set relative line numbers 
vim.opt.belloff = 'all'                  -- no beeping or flashing 
vim.opt.tabstop = 4                      -- tab width 
vim.opt.shiftwidth = 4                   -- auto-indent width 

-- Search improvements
vim.opt.incsearch = true                 -- Incremental search as you type 
vim.opt.hlsearch = true                  -- Highlight search results [cite: 2]
vim.opt.ignorecase = true                -- Case insensitive search [cite: 2]
vim.opt.smartcase = true                 -- Case sensitive if search contains uppercase [cite: 2]
vim.opt.magic = true                     -- for regex [cite: 2]

-- Display improvements
vim.opt.showcmd = true                   -- Show command in bottom bar 
vim.opt.showmatch = true                 -- Highlight matching brackets 
vim.opt.showmode = false
vim.opt.wildmenu = true                  -- Visual autocomplete for command menu 
vim.opt.ruler = true                     -- Show cursor position 
vim.opt.cmdheight = 1                    -- command line size 

-- Highlight the current line 
vim.opt.cursorline = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'


-- Indentation & formatting
vim.opt.autoindent = true                -- Auto-indent new lines 
vim.opt.smartindent = true               -- Smart indentation 
vim.opt.expandtab = true                 -- Use spaces instead of tabs 

-- Recommended settings for Neovim's built-in LSP/completion
vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
vim.opt.shortmess:append 'c' -- Supress the "continuing" messages from completion

-- Editing improvements
-- Note: 'backspace' option is a string of comma-separated values
vim.opt.backspace = 'indent,eol,start'   -- Make backspace work as expected 
vim.opt.mouse = 'a'                      -- Enable mouse support 
vim.schedule(function()                  -- sync clipboard with system
  vim.o.clipboard = 'unnamedplus'
end)

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 500

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Performance & UX
vim.opt.autoread = true                  -- 
vim.opt.undofile = true                  -- 

-- Keep all temporary files in a dedicated, hidden directory
local home = os.getenv("HOME")
vim.opt.undodir = home .. '/.nvim/undodir'
vim.opt.swapfile = false -- Disable swap files (less error prone with undofile)
vim.opt.backupdir = home .. '/.nvim/backupdir'
vim.opt.directory = home .. '/.nvim/swp'

-- Ensure the directories exist
if not vim.loop.fs_stat(home .. '/.nvim/undodir') then
  vim.fn.mkdir(home .. '/.nvim/undodir', 'p')
end

-- Note: 'completeopt' is a string of comma-separated values
vim.opt.completeopt = 'menuone,longest,preview' -- 

-- Scroll offset
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- Key Mappings and Commands

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Key Mappings
-- In Lua, we use vim.keymap.set(mode, lhs, rhs, opts)

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quick save
vim.keymap.set('n', '<leader>w', ':w<CR>', { silent = true, noremap = true }) -- nnoremap <leader>w :w<CR> 

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Toggle spell checking
vim.keymap.set({ 'n', 'i' }, '<leader>ss', ':setlocal spell!<cr>') -- map <leader>ss :setlocal spell!<cr> [cite: 7]

-- vim-plug
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug ('junegunn/fzf', { ['dir'] = '~/.fzf', ['do'] = './install --all' })
Plug ('junegunn/fzf.vim')
Plug ('nvim-lua/plenary.nvim')
Plug ('nvim-telescope/telescope.nvim', { ['tag'] = 'v0.2.0' })

vim.call('plug#end')

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')


-- Colorscheme
vim.cmd('colorscheme habamax')
