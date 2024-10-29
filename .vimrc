let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'fcpg/vim-orbital'
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/vim-clang-format'
Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set number
set relativenumber
map =  :Tex<CR>

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

autocmd InsertEnter,InsertLeave * set cul!
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

nnoremap <c-s> :w<CR> " normal mode: save
inoremap <c-s> <Esc>:w<CR>l " insert mode: escape to normal and save
vnoremap <c-s> <Esc>:w<CR> " visual mode: escape to normal and save

let g:clang_format#auto_format=1

syntax enable
filetype plugin indent on
nnoremap gb :buffers<CR>:buffer<Space>

colorscheme orbital
