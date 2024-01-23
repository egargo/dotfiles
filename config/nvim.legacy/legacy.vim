se nocompatible            " Disable Vi compatibility.
filetype on                 " Filetype must be 'on' before setting it 'off'
                            " otherwise it exists with a bad status and breaks
                            " git commit.
filetype off


" Plugins
call plug#begin('~/.config/nvim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" ----- VIM -----
syntax on                   " Enable syntax highlighting.
filetype plugin indent on   " Enable detection, plugins, and indent.
set nomodeline              " Don't use modeline (security).
set backspace=2

set noexpandtab
set copyindent              " Copy previous indentation on auto indent.
set preserveindent
set softtabstop=0
set tabstop=4               " Set tab to 4 spaces
set shiftwidth=4            " Set shift width to 4 spaces.

set mouse=a                 " Use mouse in all modes.
"set mouse=nicr
set wildmenu
set wrap                    " Set wrap.
set ttyfast
set fileformat=unix         " Set file format.
set encoding=UTF-8 nobomb   " Set UTF-8.


" Backup and swap files
set hidden
set nobackup
set nowritebackup
set noswapfile


" Performance / buffer
set lazyredraw
set number relativenumber
set numberwidth=5
set ruler


" UI
set t_Co=256                            " Set term colour.
"set termguicolors
set colorcolumn=80                      " Set column width to 80.
hi colorColumn ctermbg=8                " Set column colour.
hi Comment ctermfg=8
set background=dark
set t_ut=
"hi Normal guibg=none guifg=none			" Follow terminal theme.
hi LineNr ctermfg=grey


" Locale
setlocal nospell spelllang=en_gb
hi clear SpellBad
hi SpellBad cterm=underline,bold


" History / file handing
set undolevels=999
set history=999
set autoread        " Reload files if changed externally.


" Search
set gdefault                " RegExp global by default.
set magic                   " Enable exte:nded regex.
set hlsearch                " Highilight searches.
set incsearch               " Show the best match so far as typed.
"set ignorecase smartcase    " Make searches case-sensitive.
set showmode    " Show the current mode.
set showmatch   " Show matching parenthesis.
"set showcmd     " Show partial command on the last line of the screen.


" Disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" Keybindings
"noremap h j	" Down
"noremap j k	" Up
"noremap k h	" Left

vmap <C-c> "+yi
vmap <C-x> "+c
imap <C-v> <ESC>"+pa


" Statusline
set laststatus=2                        " Always show statusline.
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }


" ----- mouse and cursor -----
if has("autocmd")
  au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
  au InsertEnter,InsertChange *
    \ if v:insertmode == 'i' |
    \   silent execute '!echo -ne "\e[6 q"' | redraw! |
    \ elseif v:insertmode == 'r' |
    \   silent execute '!echo -ne "\e[4 q"' | redraw! |
    \ endif
  au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif