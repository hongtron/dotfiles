set nocompatible
syntax on

call plug#begin('~/.config/nvim/plugged')

Plug '~/.config/nvim/local-plugins/color-schemes'
Plug '~/.config/nvim/local-plugins/language-mappings'

Plug 'ElmCast/elm-vim', {'commit': 'ae5315396cd0f3958750f10a5f3ad9d34d33f40d'}
Plug 'benmills/vimux', {'commit': '2285cefee9dfb2139ebc8299d11a6c8c0f21309e'} | Plug 'janko-m/vim-test', {'commit': 'v2.1.0'}
Plug 'bkad/CamelCaseMotion', {'commit': '3ae9bf93cce28ddc1f2776999ad516e153769ea4'}
Plug 'cespare/vim-toml', {'commit': 'f6f79f3cc6740dfacca73a195857cbc45e778912'}
Plug 'elixir-lang/vim-elixir', {'commit': 'fe7daaaff030e217dffedf53cb5f426099281e3e'} | Plug 'slashmili/alchemist.vim', {'tag': '2.7.0'}
Plug 'fatih/vim-go', {'tag': 'v1.15', 'do': ':GoInstallBinaries'}
Plug 'jtratner/vim-flavored-markdown', {'commit': '4a70aa2e0b98d20940a65ac38b6e9acc69c6b7a0'}
Plug 'junegunn/fzf', { 'tag': '0.16.8', 'dir': '~/.fzf', 'do': './install --bin' } | Plug 'junegunn/fzf.vim', {'commit': '990834ab6cb86961e61c55a8e012eb542ceff10e'}
Plug 'junegunn/goyo.vim', {'tag': '1.6.0'}
Plug 'pangloss/vim-javascript', {'tag': '1.2.5.1'}
Plug 'rodjek/vim-puppet', {'commit': 'd881b93dc4a8ed1374ad44439aeeb47808a6b91a'}
Plug 'rust-lang/rust.vim', {'commit': '7e1e2d259adb0c8c464cb6db6074c55f39fcfba7'}
Plug 'scrooloose/nerdtree', {'tag': '5.0.0'}
Plug 'tomtom/tcomment_vim', {'tag': '3.08'}
Plug 'tpope/vim-endwise', {'commit': '0067ceda37725d01b7bd5bf249d63b1b5d4e2ab4', 'for': ['ruby']}
Plug 'tpope/vim-fugitive', {'commit': '008b9570860f552534109b4f618cf2ddd145eeb4'}
Plug 'tpope/vim-ragtag', {'commit': '0ef3f6a5778467fbca12b7874a4509593b209228'}
Plug 'tpope/vim-rails', {'commit': 'abf87ba2ebe07e1a4112a7921c06842070ef2f81'}
Plug 'tpope/vim-surround', {'commit': 'e49d6c2459e0f5569ff2d533b4df995dd7f98313'}
Plug 'tpope/vim-repeat', {'commit': '070ee903245999b2b79f7386631ffd29ce9b8e9f'}
Plug 'tpope/vim-abolish', {'commit': 'b6a8b49e2173ba5a1b34d00e68e0ed8addac3ebd'}
Plug 'vim-erlang/vim-erlang-runtime', {'commit': 'bafee7c69b23cc2923fda9ac16d6f83433645f30'}
Plug 'vim-ruby/vim-ruby', {'commit': '666adb5bcdfb2d21572a58fcdf7545a26bac32a0'}
Plug 'vim-scripts/matchit.zip', {'tag': '1.9'}
Plug 'w0rp/ale', {'tag': 'v1.3.0'}
Plug 'wlangstroth/vim-racket', {'commit': '6b62e5f50ea94aa41537fb8691abed8f30f4b107'}
Plug 'godlygeek/tabular', {'tag': '1.0.0'}
Plug 'ekalinin/Dockerfile.vim', {'commit': 'c3e2568c0f09ffb5b84b3c16e1e366285afed31b'}
Plug 'edkolev/tmuxline.vim', {'commit': '05c687014272abca548d72cfd5d8a7b7c3fb7e5e'}

call plug#end()

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

" fzf
let $FZF_DEFAULT_COMMAND = 'find * -type f 2>/dev/null | grep -v -E "deps\/|_build\/|node_modules\/|vendor\/|build_intellij\/"'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = {'up': '~20%'}
let g:fzf_tags_command = 'ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .'

" Vimux
let g:VimuxUseNearestPane = 1

" vim-test
let test#strategy = "vimux"

function! ClearTransform(cmd) abort
  return 'clear; ' . a:cmd
endfunction

let g:test#custom_transformations = {'clear': function('ClearTransform')}
let g:test#transformation = 'clear'

let g:VimuxOrientation = "h"
let g:VimuxHeight = "40"

let g:go_highlight_trailing_whitespace_error = 0

" ale
let g:ale_lint_on_text_changed = "normal"
let g:ale_lint_on_insert_leave = 1
let g:ale_linters = {'java': []}

nnoremap <silent> <leader>rf :wa<CR>:TestNearest<CR>
nnoremap <silent> <leader>rb :wa<CR>:TestFile<CR>
nnoremap <silent> <leader>ra :wa<CR>:TestSuite<CR>
nnoremap <silent> <leader>rl :wa<CR>:TestLast<CR>

imap <C-L> <SPACE>=><SPACE>
imap <C-E>= <lt>%=  %><esc>hhi
imap <C-E>- <lt>%  %><esc>hhi
imap jj <C-C>
map <silent> <LocalLeader>rt :!ctags -R --exclude=".git" --exclude="node_modules" --exclude="vendor" --exclude="log" --exclude="tmp" --exclude="db" --exclude="pkg" --exclude="deps" --exclude="_build" --extra=+f .<CR>
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <leader>ff :Files<CR>
map <silent> <leader>fg :GFiles<CR>
map <silent> <leader>fb :Buffers<CR>
map <silent> <leader>ft :Tags<CR>
map <silent> <LocalLeader>nh :nohls<CR>
map <silent> <LocalLeader>cc :TComment<CR>

nnoremap <LocalLeader>p :set paste!<CR>
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
