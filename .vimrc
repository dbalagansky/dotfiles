set nocompatible

" Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'w0rp/ale'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fixers = {
      \   'python': ['yapf', 'isort'],
      \}
let g:ale_linters = {
      \   'python': [],
      \}
"let g:ale_python_yapf_executable = $HOME . '/.virtualenvs/neovim3/bin/yapf'
"let g:ale_python_isort_executable = $HOME . '/.virtualenvs/neovim3/bin/isort'
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 0
let g:ale_enabled = 1

"Plugin 'python-mode/python-mode'
"let g:pymode_python = 'python3'
"let g:pymode_options_colorcolumn = 0
"let g:pymode_lint_unmodified = 1
"let g:pymode_rope_completion = 1
"let g:pymode_rope_complete_on_dot = 1
"let g:pymode_rope_completion_bind = '<C-f>'

"Plugin 'davidhalter/jedi-vim'
"let g:jedi#completions_command = "<leader>c"
"autocmd FileType python setlocal completeopt-=preview
"let g:jedi#auto_initialization = 0

"Plugin 'Shougo/deoplete.nvim'
"let g:deoplete#enable_at_startup = 1
"Plugin 'zchee/deoplete-jedi'

"Plugin 'maralla/completor.vim'
"let g:completor_python_binary = $HOME . '/.virtualenvs/neovim3/bin/python'

Plugin 'ludovicchabant/vim-gutentags'

"Plugin 'scrooloose/nerdcommenter'
"Plugin 'scrooloose/nerdtree'

"Plugin 'twerth/ir_black'
"Plugin 'chriskempson/base16-vim'
"Plugin 'kaicataldo/material.vim'
"Plugin 'jdkanani/vim-material-theme'

call vundle#end()

if has('nvim')
  "set termguicolors
  let g:python3_host_prog = $HOME . '/.virtualenvs/neovim3/bin/python'
  "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Turn on filetype detection, indent, and load ftplugins
filetype indent plugin on
syntax on
" Set colorscheme
set bg=dark
colorscheme ron

" VIMDIFF COLORS FIX {{{
highlight DiffAdd term=reverse cterm=bold ctermbg=green ctermfg=black
highlight DiffChange term=reverse cterm=bold ctermbg=cyan ctermfg=black
highlight DiffText term=reverse cterm=bold ctermbg=gray ctermfg=black
highlight DiffDelete term=reverse cterm=bold ctermbg=red ctermfg=black
" }}}

" FOLDING {{{
set foldmethod=indent
set foldlevel=99
" }}}

set expandtab
set clipboard=unnamed

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

autocmd BufNewFile,BufRead SCons* setf scons
autocmd BufNewFile,BufRead *.sql set filetype=mysql
autocmd BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix
autocmd BufNewFile,BufRead *.py set tabstop=4 shiftwidth=4 textwidth=79 softtabstop=4 expandtab autoindent fileformat=unix formatprg=yapf
autocmd BufNewFile,BufRead *.yaml set tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix
autocmd BufNewFile,BufRead *.go set tabstop=4 shiftwidth=4 textwidth=79 softtabstop=4 noexpandtab autoindent fileformat=unix list&
autocmd FileType gitcommit setlocal spell spelllang=en
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 textwidth=79 softtabstop=2 expandtab autoindent fileformat=unix foldmethod=marker foldmarker=\ {{{,\ }}}
"autocmd BufWritePre *.py 0,$!yapf<CR><C-o>
"autocmd BufWritePre *.py 0,$!isort -y -<CR><C-o>

" SESSIONS {{{
autocmd VimLeave * nested if !argc() | mksession! Session.vim | endif
autocmd VimEnter * nested if !argc() | if filereadable('Session.vim') | source Session.vim | endif | endif
command! SE mks! Session.vim
" }}}

set path+=**

command! TA !ctags -R .
command! VR !vagrant rsync
command! VS !vagrant ssh

" VIMRC HANDLING {{{
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" }}}

set listchars=tab:>>,trail:.,nbsp:~
set list

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

autocmd WinEnter,BufRead * setlocal nocursorline

autocmd QuickFixCmdPost *grep* cwindow

" Do not beep or flash screen
set visualbell t_vb=
" Allow to move cursor one character towards the end of line
" Another good choice is:
"set virtualedit=all
set virtualedit=onemore
" $ -- put $ and the end of the changed text,
set cpoptions+=$
" Check file for set commands
set modeline
" How many lines are checked for set commands
set modelines=5
" Do not redraw screen while executing macros
set lazyredraw
" Allow backspacing over autoindent, eol and start of the insert
set backspace=2
" Keymap
if filereadable($VIMRUNTIME . '/keymap/russian-jcukenwin.vim')
  set keymap=russian-jcukenwin
endif
" EN is default in insert mode
set iminsert=0
" EN is default in search
set imsearch=0

" SEARCHING
" Search during typing in pattern
set incsearch
" Ignore case in search patterns
set ignorecase
" Override ignorecase if search pattern contains upper case characters
set smartcase
" Do not wrap searches
set nowrapscan
set hlsearch

" SCROLLING
" Number of lines to scroll
set scrolljump=1
" Minimal number of lines to keep above and below the cursor
set scrolloff=5

" INDENTING
set tabstop=4
set shiftwidth=4
set softtabstop=4
" Copy indent from the current line when starting a new line
set autoindent
" Do smartindenting, depending on language
set smartindent

" ENCODING
" Terminal encoding
set termencoding=utf8
set encoding=utf8
" List of encodings that Vim will try to use when loading a file
set fileencodings=utf8,koi8-r

" STATUS LINE
" Number of screen lines to use for command line
set cmdheight=1
" Show cursor position in the statusline
" Commented out, because this settings are overriden in statusline
"set ruler
" Show command in the last line of the screen
"set showcmd
" Show line numbers
set number
" Wrap long lines, while not modifying file contents
set linebreak
" What to show in statusline
set statusline=%<%F%h\ %y\[%{&encoding}\]%m%r%=%c,%l/%L\ %P
" Always show status line
set laststatus=2
" Hide buffers, when they are abandoned
set hidden
" Complete only the first match (for wildmenu)
"set wildmode=""
" Show completions in statusline
set wildmenu
set wildignore+=Session.vim,tags

set mouse=

" KEY BINDINGS
vmap y y`]
cnoremap <ESC>p <Up>
cnoremap <ESC>n <Down>
nnoremap / :setlocal hlsearch<CR>/

let mapleader=","
nmap <leader>rc :tabedit ~/.vimrc<CR>
"nmap <leader>s :setlocal hlsearch! <CR>
"map <S-Enter> O<ESC>
"map <Enter> o<ESC>
"noremap <silent> ,bd :bd<CR>
"noremap <silent> ,bn :bn<CR>
"noremap <silent> ,bp :bp<CR>
