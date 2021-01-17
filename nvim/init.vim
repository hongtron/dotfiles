set nocompatible
syntax on

" Leader key
" " remove default mapping of space to move right
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader=" "

call plug#begin('~/.config/nvim/plugged')

Plug '~/.config/nvim/local-plugins/color-schemes'
Plug '~/.config/nvim/local-plugins/language-mappings'

Plug 'benmills/vimux'
Plug 'bkad/CamelCaseMotion'
Plug 'cespare/vim-toml'
Plug 'dansomething/coc-java-debug', {'do': 'yarn install --frozen-lockfile'}
Plug 'edkolev/tmuxline.vim', {'commit': '05c687014272abca548d72cfd5d8a7b7c3fb7e5e'}
Plug 'ekalinin/Dockerfile.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'godlygeek/tabular'
Plug 'janko-m/vim-test'
Plug 'jlanzarotta/bufexplorer', { 'commit': 'f3bbe12664b08038912faac586f6c0b5104325c3' }
Plug 'jtratner/vim-flavored-markdown'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-java', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
" requires nodejs, neovim python package (pynvim)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pangloss/vim-javascript'
Plug 'pgr0ss/vim-github-url'
Plug 'rodjek/vim-puppet'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'w0rp/ale'

call plug#end()

setglobal visualbell

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

" tmuxline
let g:tmuxline_powerline_separators = 0

let g:rubycomplete_buffer_loading = 1

let g:no_html_toolbar = 'yes'

let NERDTreeIgnore=['\.pyc$', '\.o$', '\.class$']

" fugitive
"
" automatically open quickfix menu after grep to see results
autocmd QuickFixCmdPost *grep* cwindow
map <silent> <leader>gw :Ggrep <cword><CR>

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

" Vimux
let g:VimuxUseNearestPane = 1

" vim-test
let test#strategy = "vimux"

" function! ClearTransform(cmd) abort
"   return 'clear; ' . a:cmd
" endfunction
"
" let g:test#custom_transformations = {'clear': function('ClearTransform')}
" let g:test#transformation = 'clear'

let g:VimuxOrientation = "h"
let g:VimuxHeight = "40"

let g:go_highlight_trailing_whitespace_error = 0

" ale
set omnifunc=ale#completion#OmniFunc
autocmd CompleteDone * pclose " close the preview window after selecting completion
let g:ale_lint_on_text_changed = "normal"
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {'java': []}
nmap <silent> <leader>ap <Plug>(ale_previous_wrap)
nmap <silent> <leader>an <Plug>(ale_next_wrap)
nmap <silent> <leader>gd :ALEGoToDefinition<CR>

"coc
let g:coc_start_at_startup = 0
autocmd FileType java :CocStart
autocmd FileType rust :CocStart

nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

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
map <silent> <leader>nt :NERDTreeToggle<CR>
map <silent> <leader>nf :NERDTreeFind<CR>
map <silent> <leader>ff :SmartFuzzy<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>
map <silent> <leader>nh :nohls<CR>
map <silent> <leader>cc :TComment<CR>

nnoremap <leader>p :set paste!<CR>
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> Y y$

if &t_Co == 256
  colorscheme jellybeans
endif

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

set laststatus=2

set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " buffer number, and flags
set statusline+=%-40f\                    " relative path

set statusline+=%=                        " seperate between right- and left-aligned
set statusline+=%1*%y%*%*\                " file type
set statusline+=%10(L(%l/%L)%)\           " line
set statusline+=%2(C(%v/125)%)\           " column
set statusline+=%P                        " percentage of file

set undodir=~/.config/nvim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

so ~/.init.vim.local
