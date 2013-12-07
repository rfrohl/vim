" general stuff
set nocompatible
filetype plugin indent on

" basics   {{{
" enable syntax highlighting
syntax enable

" enable line numbers
set number

" endcoding
set encoding=utf-8

" menu for choosing files
set wildmode=longest:full
set wildmenu
set wildignore=*.o,*.obj,*.aux,*.nav,*.out,*.snm,*.toc

" highlight the line with the cursor
set cursorline

" space around the cursor (above & below)
set scrolloff=5

" write changes to file on certain occasions
set autowrite

set backspace=indent,eol,start

" make sure there is no sound when an error takes place
set noerrorbells

" jump briefly to matching brackets
set showmatch

" formating
set textwidth=79
set colorcolumn=85

" Sets spaces used for (auto)indent
set tabstop=2
set shiftwidth=2
set softtabstop=2

" Tab key inserts spaces instead of tabs
set expandtab
set smarttab

" Indent to nearest tabstop
set shiftround

" indent
set cindent
"set autoindent

" spellcheck
setlocal spell spelllang=de_20
set nospell

" security: prevent modeline exploits
set modelines=0

" TODO look into the folowing:
"set ttyfast
"set ruler
"set relativenumber


" }}}

" search {{{

set incsearch
set hlsearch
set ignorecase
"set smartcase

" }}}

"" Status line {{{
"
"set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)
"
"" }}}

"" Backups {{{
"
"set backupdir=~/.vim/tmp/backup// " backups
"set directory=~/.vim/tmp/swap//   " swap files
"set backup                        " enable backups
"
"" }}}

" folding {{{

set foldmethod=indent
set foldlevelstart=2

" }}}

" macros {{{

" romove all trailing whitespace
au BufWritePre * :%s/\s\+$//e

" changes working directory to the directory of the last opened file
au BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif
"autocmd BufEnter * :lcd %:p:h

" go to the line where the last edit took place
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\""| endif

" }}}

" color scheme {{{
set t_Co=256

"colorscheme molokai_new
colorscheme molokai
let g:molokai_original=1
"let g:rehash256 = 1
set background=dark

" }}}

" key mappings {{{

" leader
let mapleader = ","

" learning vim
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" }}}

"" PLUGINS  {{{

"" latex-suite
"lower priority in tab completion
set suffixes+=.aux,.log,.toc,.dvi " LaTeX
set suffixes+=.eps,+.pdf

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
"let g:Tex_ViewRule_ps  = 'evince'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_ViewRule_dvi = 'evince'

"" NERDTree
map <silent> <F2> :NERDTreeToggle<CR>

"" YankRing
nnoremap <silent> <F11> :YRShow<CR>

"" Rainbows Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

" }}}

