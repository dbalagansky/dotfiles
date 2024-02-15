set nocompatible

filetype indent plugin on
syntax on

set t_Co=16
set bg=dark
colorscheme default

" COLOUR FIXES BASED OFF NOCTU AND VIM-DIM
highlight LineNr ctermfg=0 ctermbg=NONE
highlight Visual ctermfg=NONE ctermbg=NONE cterm=inverse
highlight IncSearch ctermfg=0 ctermbg=3 cterm=NONE
highlight Search ctermfg=0 ctermbg=3
highlight Pmenu ctermfg=7 ctermbg=0
highlight PmenuSel ctermfg=NONE ctermbg=NONE cterm=inverse
highlight MatchParen ctermfg=8 ctermbg=NONE cterm=inverse

" VIMDIFF COLORS FIX {{{
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
" }}}

" Two-color colorscheme {{{
highlight Normal cterm=NONE ctermfg=NONE
highlight Comment cterm=NONE ctermfg=8
highlight Constant cterm=NONE ctermfg=NONE
highlight Identifier cterm=NONE ctermfg=NONE
highlight Function cterm=NONE ctermfg=NONE
highlight Statement cterm=NONE ctermfg=NONE
highlight PreProc cterm=NONE ctermfg=NONE
highlight Type cterm=NONE ctermfg=NONE
highlight Special cterm=NONE ctermfg=NONE
highlight Delimiter cterm=NONE ctermfg=NONE
" }}}

highlight ColorColumn ctermfg=NONE ctermbg=NONE cterm=inverse
call matchadd('ColorColumn', '\%81v', 100)

" FOLDING {{{
set foldmethod=indent
set foldlevel=99
" }}}

autocmd BufNewFile,BufRead SCons* setf scons
autocmd BufNewFile,BufRead *.sql set filetype=mysql
autocmd BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix
autocmd BufNewFile,BufRead *.py set tabstop=4 shiftwidth=4 textwidth=88 softtabstop=4 expandtab autoindent fileformat=unix formatprg=yapf\ \|\ isort\ -y\ -
autocmd BufNewFile,BufRead *.go set tabstop=4 shiftwidth=4 textwidth=79 softtabstop=4 noexpandtab autoindent fileformat=unix list&
autocmd BufNewFile,BufRead *.c set tabstop=4 shiftwidth=4 textwidth=79 softtabstop=4 noexpandtab autoindent fileformat=unix list&
autocmd BufNewFile,BufRead *.lua set tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix
autocmd FileType gitcommit setlocal spell spelllang=en
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix foldmethod=marker foldmarker=\ {{{,\ }}}
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix
"autocmd BufWritePre *.py 0,$!yapf<CR><C-o>
"autocmd BufWritePre *.py 0,$!isort -y -<CR><C-o>

autocmd WinEnter,BufRead * setlocal nocursorline

autocmd QuickFixCmdPost *grep* cwindow

" Open file at last edited location
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" SESSIONS {{{
autocmd VimLeave * nested if !argc() | mksession! Session.vim | endif
autocmd VimEnter * nested if !argc() | if filereadable('Session.vim') | source Session.vim | endif | endif
command! SE mks! Session.vim
" }}}

" VIMRC HANDLING {{{
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" }}}

command! TA !ctags -R .

" NETRW (FILE EXPLORER) {{{
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
autocmd FileType netrw hi CursorLine term=underline
autocmd FileType netrw au BufEnter <buffer> hi CursorLine term=underline
autocmd FileType netrw au BufLeave <buffer> hi clear CursorLine
autocmd FileType netrw setlocal winfixwidth
" }}}

set expandtab
set clipboard=unnamed
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif
set directory=$HOME/.vim/swapfiles//
set path+=**
set listchars=tab:>>,trail:.,nbsp:~
set list
set number
set mouse=
set visualbell t_vb=
set virtualedit=onemore
set cpoptions+=$
set modeline
set modelines=5
set lazyredraw
set backspace=2

" VIM KEYMAP SETTINGS {{{
if filereadable($VIMRUNTIME . '/keymap/russian-jcukenwin.vim')
  set keymap=russian-jcukenwin
endif
set iminsert=0
set imsearch=0
" }}}

" SEARCHING
set incsearch
set ignorecase
set smartcase
set nowrapscan
set hlsearch

" SCROLLING
set scrolljump=1
set scrolloff=5

" INDENTING
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

" ENCODING
set termencoding=utf8
set encoding=utf8
set fileencodings=utf8

" STATUS LINE
set cmdheight=1
set linebreak
set statusline=%<%F%h\ %m%r%=%c\ %P/%L
set laststatus=2
set hidden
set wildmenu
set wildignore+=Session.vim,tags,venv,.venv

" KEY BINDINGS
vmap y y`]
cnoremap <ESC>p <Up>
cnoremap <ESC>n <Down>
nnoremap / :setlocal hlsearch<CR>/
