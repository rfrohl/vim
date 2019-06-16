"" basics
set nocompatible
syntax enable
filetype plugin indent on
execute pathogen#infect()
let mapleader = ","
set title

set encoding=utf-8

" disable swap files
set noswapfile
set hidden

" menu for choosing files
set wildmode=list:longest,full
set wildmenu
set wildignore=*.o,*.obj,*.aux,*.nav,*.out,*.snm,*.swp,*.toc

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

" spell check
set spelllang=en_us
nmap <silent> <leader>s :set spell! <CR>


" security: prevent modeline exploits
set modelines=0

" line numbers
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"" search
set incsearch
set hlsearch
set ignorecase
set smartcase


"" replace
set gdefault    " :%s/foo/bar should replace in whole file not just current line


"" folding
set foldmethod=indent
set foldlevelstart=10


"" color scheme
colorscheme molokai
set t_Co=256
set t_ut=
let g:rehash256=1
set background=dark


"" key mappings

" :W should save as well
command W w
command Wq wq
command WQ wq
command Q q

" move between tabs using shift+h/l
nnoremap <S-h> gT
nnoremap <S-l> gt

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

"" Gblame
nnoremap <silent> <F3> :Gblame<CR>

"" Hexedit
nnoremap <F4> :Hexmode<CR>
inoremap <F4> <Esc>:Hexmode<CR>
vnoremap <F4> :<C-U>Hexmode<CR>

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


"" Tagbar
nnoremap <silent> <F5> :TagbarToggle<CR>


"" YankRing
nnoremap <silent> <F11> :YRShow<CR>


" ========================================================================
" File type matching
" ========================================================================

if has("autocmd")
    " go to the line where the last edit took place
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\""| endif

    " Turn off line wrap for common files
    au BufNewFile,BufRead db.*	    setlocal nowrap nofen
    au BufNewFile,BufRead /etc/*	setlocal nowrap nofen


    "" C
    au FileType c         setl sw=8 ts=8 sts=8 expandtab cindent "list

    " a.vim
    let g:alternateSearchPath = "sfr:.,sfr:../include,sfr:../inc,sfr:./include,sfr:../source,sfr:../src"
    map <silent> <Leader>a :A <CR>


    "" Python
    au FileType python setl ts=4 sts=4 sw=4 expandtab

    "" Ruby
    au FileType ruby setl ts=2 sts=2 sw=2 expandtab

    "" yaml
    au FileType yaml setl ts=2 sts=2 sw=2 expandtab
    au FileType yml setl ts=2 sts=2 sw=2 expandtab

    "" web stuff
    au FileType js,html,css setl ts=2 sts=2 sw=2 expandtab

    "" misc
    au BufNewFile,BufRead _patchinfo set syntax=xml | setl spell

    "" always spellcheck certain file types
    au FileType markdown setl spell
    au FileType changes setl spell
    au FileType xml setl spell
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
map <Leader>p :CtrlP <CR>
map <Leader>b :CtrlPBuffer <CR>
map <Leader>m :CtrlPMixed <CR>
"" ctrlp + ctags
map <Leader>c :CtrlPTag <CR>

" added 'venv' normally used for virtualenv
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|venv$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }


"" Airline
set laststatus=2
let g:airline_theme = 'molokai'
let g:airline#extensions#tmuxline#enabled = 0

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
"au BufWritePre * :call TrimWhiteSpace()

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

" add an XML stopped flag with current date
map <Leader>w o<stopped>rfrohl: <Esc>:r !date +\%Y-\%m-\%d<CR>kJ o: </stopped><Esc>kJxl
