" Disable vi compatibility
set nocompatible

" Used for some plugins to display fancy symbols.  Hopefully doesn't blow
" things up.
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-run-interactive'
Plug 'croaky/vim-colors-github'
Plug 'danro/rename.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kchmck/vim-coffee-script'
Plug 'pbrisbin/vim-mkdir'
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/ctags.vim'
Plug 'vim-scripts/matchit.zip'

Plug 'tomtom/tcomment_vim'
Plug 'mattn/emmet-vim'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-powerline'
Plug 'godlygeek/tabular'
Plug 'jelera/vim-javascript-syntax'
Plug 'altercation/vim-colors-solarized'
Plug 'othree/html5.vim'
Plug 'xsbeats/vim-blade'
Plug 'Raimondi/delimitMate'
Plug 'groenewege/vim-less'
Plug 'Lokaltog/vim-easymotion'
Plug 'dikiaap/minimalist'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'tpope/vim-commentary'
Plug 'wookayin/vim-typora'
Plug 'wakatime/vim-wakatime'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'
Plug 'pangloss/vim-javascript'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'wavded/vim-stylus'
Plug 'isRuslan/vim-es6'

call plug#end()


" fzf support
set rtp+=/usr/local/opt/fzf
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" Set ultisnips triggers
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Ack search
let g:ackprg = 'ag --nogroup --nocolor --column'

" Highlight current line
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn

" Leader
let mapleader = " "
" let mapleader = ","
:nmap ; <space>


nnoremap <leader>f :FZF<CR>

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

augroup vimrcEx
  autocmd!

  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.json.jbuilder set filetype=ruby

  autocmd FileType markdown setlocal spell

  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Color scheme
set t_Co=256
syntax on
colorscheme minimalist
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Make it obvious where 80 characters is
" set textwidth=80
" set colorcolumn=+1

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
      return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

imap jk <ESC>
imap <C-f> <C-o>a
imap <C-e> <C-o>A

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>r :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

let g:rspec_command = 'Dispatch rspec -f d -c {spec}'
" let g:rspec_command = "!bundle exec rspec -f d -c {spec}"
let g:rspec_runner = "os_x_iterm2"

" Run commands that require an interactive shell
nnoremap <Leader>s :RunInInteractiveShell<space>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]

" autocmd Syntax javascript set syntax=jquery " JQuery syntax support

set matchpairs+=<:>
set statusline+=%{fugitive#statusline()} "  Git Hotness

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=40
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
autocmd vimenter * if !argc() | NERDTree | endif " Automatically open a NERDTree if no files where specified
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Close vim if the only window left open is a NERDTree
nmap <C-g> :NERDTreeToggle<cr>
nnoremap <leader>h :NERDTreeFind<CR>
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'

" Emmet
let g:user_emmet_mode='i' " enable for insert mode
" let g:user_emmet_install_global = 0
" autocmd FileType html,css,vue EmmetInstall
let g:user_emmet_leader_key='<C-E>'

" Search results high light
set hlsearch

" nohlsearch shortcut
nmap -hl :nohlsearch<cr>
nmap +hl :set hlsearch<cr>

" Javascript syntax hightlight
syntax enable

autocmd BufEnter * :syntax sync fromstart

" ctrap
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <leader>w :w<CR>
nnoremap <leader>e :e<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qa<CR>
nnoremap <leader>y :!<CR>

" reg past command
nnoremap <leader>g :reg<CR>
nnoremap <leader>" ""p"<CR>
nnoremap <leader>0 "0p"<CR>
nnoremap <leader>1 "1p"<CR>
nnoremap <leader>2 "2p"<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Vim-instant-markdown doesn't work in zsh
" set shell=bash\ -i
" set shell=/bin/zsh\ -l

" Snippets author
let g:snips_author = 'Yuez'

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2

set ttyfast
set lazyredraw
set clipboard=unnamed

