" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype off

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" File encoding
set encoding=utf-8

" Turn syntax highlighting on.
syntax enable

" Relative line numbers
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END


"  " Highlight cursor line underneath the cursor horizontally.
set cursorline

"  " Highlight cursor line underneath the cursor vertically.
"  set cursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" For fish shell users
" set shell=/bin/bash

let python_highlight_all=1
syntax on



" PLUGINS ------------------------------------------------------------ {{{

" Plugin code goes here.

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Add all your plugins here

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" sensible vim
Plugin 'tpope/vim-sensible'

" Python autocomplete, syntax and linting
Plugin 'ycm-core/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'

" File Browsing
Plugin 'scrooloose/nerdtree'
" Plugin 'jistr/vim-nerdtree-tabs'

" Color Themes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'tomasr/molokai', { 'name': 'molokai' } 
Bundle 'sonph/onehalf', {'rtp': 'vim/'}

" Searching
Plugin 'kien/ctrlp.vim'

" Git commands without leaving VIM
Plugin 'tpope/vim-fugitive'

" Powerline Statusbar
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'itchyny/lightline.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" }}}

" COLOR SCHEME --------------------------------------------------------------- {{{
" Choose color Scheme
colorscheme onehalfdark
" let g:airline_theme='onehalfdark'
" colorscheme dracula
" colorscheme molokai
" colorscheme zenburn
" colorscheme solarized

" let g:molokai_original = 0
let g:rehash256 = 1
" see background=dracula
" set foreground=dracula

" }}}


" PYTHON SETUP --------------------------------------------------------------- {{{
" Python setup

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Status bar and lightline
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Toggle search highligt
set hlsearch!
nnoremap <F3> :set hlsearch!<CR>
nnoremap <silent><c-s> :<c-u>update<cr>
inoremap <silent><c-s> :<c-u>update<cr>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

"  " This will enable code folding.
"  " Use the marker method of folding.
"  augroup filetype_vim
"      autocmd!
"      autocmd FileType vim setlocal foldmethod=marker
"  augroup END

" More Vimscripts code goes here.

au BufNewFile,BufRead *.p
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}




