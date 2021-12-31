" General settings
set ff=unix
set backupcopy=yes
set number
set updatetime=100
set nofixendofline
set t_Co=256
set undofile
set undodir=~/.vim/undodir
syntax on

" Plugins
call plug#begin()
    Plug 'fxn/vim-monochrome'
    Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
call plug#end()

" Colors
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

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

