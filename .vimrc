" Author: Uwe Hermann <uwe@hermann-uwe.de>
" URL: http://www.hermann-uwe.de/files/vimrc
" $Id: .vimrc 331 2005-09-07 21:09:32Z uh1763 $
"------------------------------------------------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/MatchTagAlways'
Plugin 'vim-python/python-syntax'
call vundle#end()

version 6.3


"------------------------------------------------------------------------------
" Standard stuff.
"------------------------------------------------------------------------------

filetype plugin indent on

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
set esckeys             " Cursor keys in insert mode.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set tabstop=4           " Number of spaces <tab> counts for.
set expandtab
set shiftwidth=4
set ttyscroll=0         " Turn off scrolling (this is faster).
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

set sw=4 ts=4 sts=4                    " Defaults: four spaces per tab
autocmd FileType html :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
autocmd FileType js :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
autocmd FileType htmldjango :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
autocmd FileType css :setlocal sw=2 ts=2 sts=2 " Two spaces for HTML files
autocmd FileType python :setlocal ts=4 smarttab expandtab

nmap ,t4 :set ts=4<cr>

nmap ,2 :set shiftwidth=2<cr>

" Use brighter colors if your xterm has a dark background.
  set background=dark


" Enable this if you mistype :w as :W or :q as :Q.
nmap :W :w
nmap :Q :q
nmap :Wq :wq
nmap :WQ :wq
nmap :WS w !sudo tee % > /dev/null

nnoremap Q <nop>


"------------------------------------------------------------------------------
" Abbreviations.
"------------------------------------------------------------------------------


" Use 'g' to go to the top of the file.
"map g 1G
map gf <C-w>gf
map W <C-W>w
map ] <C-W>j<C-W>_
map [ <C-W>k<C-W>_
set wmh=0

" Open a new tabe in the explorer window
nmap ,t :tabe\|:Ex<cr>

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

nmap ,p :set invpaste paste?<cr>

nmap ,fh :set ft=html<cr>
nmap ,fp :set ft=php<cr>

nmap ,j :%!python -m json.tool<cr>

set scrolloff=5
" Killing Ex mode
nnoremap Q @q

set t_Co=256

colorscheme torte
