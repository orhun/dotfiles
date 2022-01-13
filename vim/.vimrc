" General settings
set ff=unix
set encoding=utf-8
set backupcopy=yes
set number
set updatetime=100
set nofixendofline
set t_Co=256
set undofile
set undodir=~/.vim/undodir
set autoread
set wildmenu
set wildmode=longest:full,full
set ignorecase
set smartcase

" Plugins
call plug#begin()
    Plug 'fxn/vim-monochrome'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
    Plug 'm-pilia/vim-pkgbuild'
    Plug 'rust-lang/rust.vim'
    Plug 'kien/ctrlp.vim'
call plug#end()

" Settings
syntax enable
filetype plugin indent on
colorscheme monochrome

" Bindings
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>l
vnoremap <c-s> <Esc>:w<CR>
inoremap <C-d> <esc>:wq!<cr>
nnoremap <C-d> :wq!<cr>
inoremap <C-q> <esc>:qa!<cr>
nnoremap <C-q> :qa!<cr>
nnoremap <Leader>ce :e $MYVIMRC<CR>
nnoremap <Leader>cr :source $MYVIMRC<CR>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

