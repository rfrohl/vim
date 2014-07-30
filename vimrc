"" basics
set nocompatible
syntax enable
filetype plugin indent on
execute pathogen#infect()

set number
set encoding=utf-8

" menu for choosing files
set wildmode=list:longest,full
set wildmenu
set wildignore=*.o,*.obj,*.aux,*.nav,*.out,*.snm,*.toc

" highlight the line with the cursor
set cursorline

" context(space) around the cursor
set scrolloff=5

" write changes to file on certain occasions
set autowrite

set backspace=indent,eol,start

" make sure there is no sound when an error takes place
set noerrorbells
"set visualbell

" jump briefly to matching brackets
set noshowmatch " turned off: it is distracting with the current colorscheme
set matchtime=3

" formating
set textwidth=79
set colorcolumn=80

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Sets spaces used for (auto)indent
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Tab key inserts spaces instead of tabs
set expandtab
set smarttab

" Indent to nearest tabstop
set shiftround

" indent
set cindent
set autoindent

" spellcheck
"setlocal spell spelllang=en_us
"set nospell

" security: prevent modeline exploits
set modelines=0

" TODO look into the folowing:
"set relativenumber

"" search
set incsearch
set hlsearch
set ignorecase
set smartcase


"" replace
set gdefault    " :%s/foo/bar should replace in whole file not just current line


"" folding
set foldmethod=indent
set foldlevelstart=2


"" color scheme
colorscheme molokai
set t_Co=256
set t_ut=
let g:rehash256=1
set background=dark


"" key mappings
let mapleader = ","

" :W should save as well
command W w
command Wq wq
command WQ wq
command Q q

" move between tabs using alt+h/l
set <m-l>=l
nnoremap <m-l> gt
set <m-h>=h
nnoremap <m-h> gT

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

" ========================================================================
" Function Keys - F*
" ========================================================================

" disable F1 help
nmap <F1> :echo<CR>
imap <F1> <C-o>:echo<CR>


"" NERDTree
map <silent> <F1> :NERDTreeTabsToggle<CR>


"" Gundo
nnoremap <F2> :GundoToggle<CR>
let g:gundo_preview_bottom = 1
let g:gundo_width = 28


"" Hexedit
nnoremap <F3> :Hexmode<CR>
inoremap <F3> <Esc>:Hexmode<CR>
vnoremap <F3> :<C-U>Hexmode<CR>

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
    " hex mode should be considered a read-only operation
    " save values for modified and read-only for restoration later,
    " and clear the read-only flag for now
    let l:modified=&mod
    let l:oldreadonly=&readonly
    let &readonly=0
    let l:oldmodifiable=&modifiable
    let &modifiable=1
    if !exists("b:editHex") || !b:editHex
        " save old options
        let b:oldft=&ft
        let b:oldbin=&bin
        " set new options
        setlocal binary " make sure it overrides any textwidth, etc.
        let &ft="xxd"
        " set status
        let b:editHex=1
        " switch to hex editor
        %!xxd
    else
        " restore old options
        let &ft=b:oldft
        if !b:oldbin
            setlocal nobinary
        endif
        " set status
        let b:editHex=0
        " return to normal editing
        %!xxd -r
    endif
    " restore values for modified and read only state
    let &mod=l:modified
    let &readonly=l:oldreadonly
    let &modifiable=l:oldmodifiable
endfunction


"" YankRing
nnoremap <silent> <F11> :YRShow<CR>


" ========================================================================
" File type matching
" ========================================================================

if has("autocmd")
    " changes working directory to the directory of the last opened file
    "au BufEnter * if expand("%:p:h") !~ '^/tmp' | lcd %:p:h | endif
    "autocmd BufEnter * :lcd %:p:h

    " go to the line where the last edit took place
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\""| endif

    " Turn off line wrap for common files
    au BufNewFile,BufRead db.*	    setlocal nowrap nofen
    au BufNewFile,BufRead /etc/*	setlocal nowrap nofen


    "" C
    au FileType c         setl sw=8 ts=8 sts=8 noexpandtab cindent "list

    " a.vim
    let g:alternateSearchPath = "sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:./include"
    map <Leader>a :A <CR>


    "" Ruby
    au FileType ruby      setl sw=2 sts=2 expandtab "list

    " RSpec
    au Filetype ruby noremap <silent> <F5> :!rspec % -I ~/Code/hmr/infrastructure/acbs/lib -I ~/Code/hmr/infrastructure/naild/lib <CR>
    "noremap <silent> <F3> :!rspec %  -I ~/Code/hmr/infrastructure/acbs/lib -I ~/Code/hmr/infrastructure/naild/lib <CR>
    "au Filetype ruby noremap <F3> <C-o>:update<Bar>execute '!rspec '.shellescape(expand('%:r'), 1)<CR>

    " RuboCop
    au Filetype ruby noremap <silent> <F6> :RuboCop<CR>
endif

" ========================================================================
" PLUGINS
" ========================================================================

"" latex-suite
"lower priority in tab completion
set suffixes+=.aux,.log,.toc,.dvi " LaTeX
set suffixes+=.eps,+.pdf

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'dvi,pdf'
"let g:Tex_ViewRule_ps  = 'evince'
let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_ViewRule_dvi = 'evince'


"" Rainbows Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let g:rbpt_colorpairs = [
    \ ['magenta',     'purple1'],
    \ ['cyan',        'magenta1'],
    \ ['green',       'slateblue1'],
    \ ['yellow',      'cyan1'],
    \ ['red',         'springgreen1'],
    \ ['magenta',     'green1'],
    \ ['cyan',        'greenyellow'],
    \ ['green',       'yellow1'],
    \ ['yellow',      'orange1'],
    \ ]
let g:rbpt_max = 9


"" ctrlp
"let g:ctrlp_map = '<c-p>'
map <Leader>p :CtrlP <CR>

" enter - open new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }


"" Airline
set laststatus=2
let g:airline_theme = 'molokai'

"" tmuxline
let g:tmuxline_separators = {
    \ 'left' : '',
    \ 'left_alt': '>',
    \ 'right' : '',
    \ 'right_alt' : '<',
    \ 'space' : ' '
    \ }


"" Tabularize
map <Leader>t :Tabularize /

" ========================================================================
" Macros
" ========================================================================

"" trim trailing whitespaces
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

" remove all trailing whitespaces when saving a file
au BufWritePre * :call TrimWhiteSpace()

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
