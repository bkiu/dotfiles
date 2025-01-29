-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "olimorris/codecompanion.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = true
    },
    {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
    },
  },
  rocks = { enabled = false },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "torte" } },
  -- automatically check for plugin updates
  checker = { enabled = true, notify = false },
})
vim.cmd([[
    set nocompatible        " Disable vi compatibility.
    set history=100         " Number of lines of command line history.
    set undolevels=200      " Number of undo levels.
    set textwidth=0         " Don't wrap words by default.
    set showcmd             " Show (partial) command in status line.
    set showmatch           " Show matching brackets.
    set showmode            " Show current mode.
    set ruler               " Show the line and column numbers of the cursor.
    set ignorecase          " Case insensitive matching.
    set incsearch           " Incremental search.
    set autoindent          " I indent my code myself.
    set cindent             " I indent my code myself.
    set scrolloff=5         " Keep a context when scrolling.
    set noerrorbells        " No beeps.
    " set nomodeline          " Disable modeline.
    set modeline            " Enable modeline.
    "set esckeys             " Cursor keys in insert mode.
    set gdefault            " Use 'g' flag by default with :s/foo/bar/.
    set magic               " Use 'magic' patterns (extended regular expressions).
    set tabstop=4           " Number of spaces <tab> counts for.
    set expandtab
    set shiftwidth=4
    "set ttyscroll=0         " Turn off scrolling (this is faster).
    set ttyfast             " We have a fast terminal connection.
    set hlsearch            " Highlight search matches.
    set encoding=utf-8      " Set default encoding to UTF-8.
    " set showbreak=+         " Show a '+' if a line is longer than the screen.
    " set laststatus=2        " When to show a statusline.
    " set autowrite           " Automatically save before :next, :make etc.
    set number

    set nostartofline       " Do not jump to first character with page commands,
                " i.e., keep the cursor in the current column.
    set viminfo='20,\"50    " Read/write a .viminfo file, don't store more than
                " 50 lines of registers.

    " Allow backspacing over everything in insert mode.
    set backspace=indent,eol,start

    " Tell vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines. VERY useful!
    "set listchars=tab:>-,trail:路,eol:$

    " Path/file expansion in colon-mode.
    set wildmode=list:longest
    set wildchar=<TAB>

    " Enable syntax-highlighting.
    if has("syntax")
      syntax on
    endif
    nmap :W :w
    nmap :Q :q
    nmap :Wq :wq
    nmap :WQ :wq
    nmap :WS w !sudo tee % > /dev/null

    nnoremap Q <nop>

    set sw=4 ts=4 sts=4                    " Defaults: four spaces per tab
    autocmd FileType html :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
    autocmd FileType js :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
    autocmd FileType javascript :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
    autocmd FileType htmldjango :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
    autocmd FileType css :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
    autocmd FileType yaml :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
    autocmd FileType python :setlocal ts=4 smarttab expandtab

    nmap J :tabp<cr>
    nmap K :tabn<cr>

    " Delete DOS carriage returns
    nmap <silent> ,m :%s/\r//g<cr>

    " Change the working directory to the current file always
    autocmd BufEnter,BufWritePost * lcd %:p:h

    " Hide pyc files in file explorer (:help netrw_list_hide)
    let g:netrw_list_hide= ".*\.pyc$,*\.pyo$,.*\.swp$"

    " This beauty remembers where you were the last time you edited the file, and returns to the same position.
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


    "------------------------------------------------------------------------------
    " Miscellaneous stuff.
    "------------------------------------------------------------------------------

    " Make p in visual mode replace the selected text with the "" register.
    vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

    inoremap jk <esc>

    nmap ,fh :set ft=html<cr>
    nmap ,fp :set ft=php<cr>

    nmap ,j :%!python -m json.tool<cr>

    set scrolloff=5
    " Killing Ex mode
    nnoremap Q @q
    set number
    colorscheme torte
]])

require("codecompanion").setup({
    adapters = {
        ollama_remote = function()    
          local token = os.getenv 'OLLAMA_TOKEN'
          local url = os.getenv 'OLLAMA_REMOTE_URL'
          return require("codecompanion.adapters").extend("ollama", {
            name = "ollama_remote",
            env = {
              url = url,
            },
            headers = {
              ["Content-Type"] = "application/json",
              ["Authorization"] = "Bearer " .. token,
            },
            parameters = {
              sync = true,
            },
            schema = {
                model = {
                    default = "nemotron:latest"
                },
                num_ctx = {
                    default = 8192,
                }
            },
          })
        end,
    },
    strategies = {
        chat = {
            adapter = "ollama_remote",
        },
        inline = {
            adapter = "ollama_remote",
        },
        agent = {
            adapter = "ollama_remote",
        },
    },
    display = {
        chat = {
            window = {
                layout = "horizontal",
                position = "bottom",
                height = 0.4,
            },
        }
    },
})

vim.cmd("highlight Normal guibg=#1C1F23")
vim.cmd("highlight StatusLine guifg=#FFFFFF guibg=#2F343B")
vim.cmd("set laststatus=1")
vim.cmd("autocmd TermOpen * setlocal nonumber norelativenumber")
vim.keymap.set({ 'n' }, "<leader>t", ":tabe|:Ex<cr>")
vim.keymap.set({ 'n' }, "<leader>p", ":set invpaste paste")
vim.keymap.set({ 'n', 'v' }, '<leader>a', ':CodeCompanionActions<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>e', ':CodeCompanion explain-selection<cr>')
vim.keymap.set({ 'n', 'v' }, '<leader>c', ':CodeCompanionChat<cr>')
vim.keymap.set({ 'n' }, '<leader>|', ':vsplit<CR>:wincmd l<CR>:terminal<CR>')
