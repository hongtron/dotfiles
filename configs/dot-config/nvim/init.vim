set nocompatible
syntax on

" Leader key
" " remove default mapping of space to move right
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=" "

call plug#begin('~/.config/nvim/plugged')

" Local
Plug '~/.config/nvim/local-plugins/color-schemes'
Plug '~/.config/nvim/local-plugins/language-mappings'

" Language/Filetype Specific
Plug 'cespare/vim-toml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'pangloss/vim-javascript'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-rails'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-ruby/vim-ruby'

" CoC
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dansomething/coc-java-debug', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}

Plug 'benmills/vimux'
Plug 'edkolev/tmuxline.vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'jlanzarotta/bufexplorer'
Plug 'jtratner/vim-flavored-markdown'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'pgr0ss/vim-github-url'
Plug 'preservim/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'

call plug#end()

" Disable bell
" https://unix.stackexchange.com/a/5313
setglobal visualbell
setglobal t_vb=

set cursorline
set background=dark
set backspace=indent,eol,start
set dir=/tmp//
set hidden
set hlsearch
set ignorecase
set incsearch
set mouse=
set nofoldenable
set number
set ruler
set scrolloff=5
set showmatch
set smartcase
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set wildignore+=*.pyc,*.o,*.class
set wrap
set noshowcmd

" Neovim
set inccommand=nosplit " highlight current results during substitution

autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
autocmd BufNewFile,BufReadPost *.go set filetype=go
autocmd BufnewFile,BufRead *.slim setlocal filetype=slim
autocmd FileType elixir setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType elm setlocal expandtab
autocmd FileType gitcommit set tw=72
autocmd FileType go setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType java setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2 nospell
autocmd FileType md setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType ruby runtime ruby_mappings.vim
autocmd FileType yml setlocal filetype=yaml expandtab

" Autoremove trailing spaces when saving the buffer
autocmd FileType ruby,elm,yml,javscript,json,go,md,slim,css,scss,js,vim autocmd BufWritePre <buffer> %s/\s\+$//e

let html_use_css=1
let html_number_lines=0
let html_no_pre=1
let g:no_html_toolbar = 'yes'
let g:rubycomplete_buffer_loading = 1
let g:go_highlight_trailing_whitespace_error = 0

" tmuxline
let g:tmuxline_powerline_separators = 0

" fugitive
" automatically open quickfix menu after grep to see results
autocmd QuickFixCmdPost *grep* cwindow
" reminder: gq to close blame window
map <silent> <leader>gb :Gblame<CR>
map <silent> <leader>gc :Gcommit<CR>
map <silent> <leader>gd :Gdiffsplit<CR>
map <silent> <leader>gw :Ggrep <cword><CR>
map <silent> <leader>gW :Ggrep -i <cword><CR>

" Vimux
let g:VimuxUseNearestPane = 1
let g:VimuxOrientation = "h"
let g:VimuxHeight = "40"

" vim-test
let test#strategy = "vimux"
" function! ClearTransform(cmd) abort
"   return 'clear; ' . a:cmd
" endfunction
" let g:test#custom_transformations = {'clear': function('ClearTransform')}
" let g:test#transformation = 'clear'

" ale
set omnifunc=ale#completion#OmniFunc
autocmd CompleteDone * pclose " close the preview window after selecting completion
let g:ale_lint_on_text_changed = "normal"
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {'java': []}
nmap <silent> <leader>ap <Plug>(ale_previous_wrap)
nmap <silent> <leader>an <Plug>(ale_next_wrap)
nmap <silent> <leader>afr :ALEFindReferences<CR>
xnoremap <silent> <leader>aca :ALECodeAction<CR>
nmap <silent> <leader>gtd :ALEGoToDefinition<CR>

" CoC
let g:coc_start_at_startup = 0
" autocmd FileType java :CocStart
autocmd FileType rust :CocStart

" vim-test
nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

" NERDTree
let NERDTreeIgnore=['\.pyc$', '\.o$', '\.class$', '__pycache__']
map <silent> <leader>nt :NERDTreeToggle<CR>
map <silent> <leader>nf :NERDTreeFind<CR>
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" fzf
let $FZF_DEFAULT_COMMAND = 'find * -type f 2>/dev/null | grep -v -E "deps\/|_build\/|node_modules\/|vendor\/|build_intellij\/"'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = {'up': '~20%'}
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .'
function! SmartFuzzy()
  let root = split(system('git rev-parse --show-toplevel'), '\n')
  if len(root) == 0 || v:shell_error
    Files
  else
    GFiles -co --exclude-standard -- . ':!:vendor/*'
  endif
endfunction
command! -nargs=* SmartFuzzy :call SmartFuzzy()
map <silent> <leader>ff :SmartFuzzy<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>

function! Trim()
  %s/\s*$//
  ''
endfunction
command! -nargs=0 Trim :call Trim()
nnoremap <silent> <Leader>cw :Trim<CR>

imap <C-L> <SPACE>=><SPACE>
imap <C-E>= <lt>%=  %><esc>hhi
imap <C-E>- <lt>%  %><esc>hhi
map <silent> <leader>rt :!ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .<CR>
map <silent> <leader>nh :nohls<CR>
map <silent> <leader>cc :TComment<CR>

nnoremap <leader>p :set paste!<CR>

" use j/k more intutively when lines are wrapped
nnoremap <silent> k gk
nnoremap <silent> j gj

nnoremap <silent> Y y$

" Appearance
if &t_Co == 256
  colorscheme jellybeans
  let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }
endif


autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

set laststatus=2 " always show statusline

set undodir=~/.config/nvim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

so ~/.init.vim.local
