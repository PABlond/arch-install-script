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
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler'
call plug#end()

" Format before saving .ts and .tsx files
augroup FormatBeforeSave
    autocmd!
    autocmd BufWritePre *.ts,*.tsx :Format
augroup END

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" " utf-8 byte sequence
set encoding=utf-8
" " Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" " delays and poor user experience
set updatetime=300

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved
set signcolumn=yes

let g:coc_global_extensions = ['coc-tsserver', 'coc-eslint', 'coc-prettier']
" Make <CR> to accept selected completion item or notify coc.nvim to format
" " <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
"
" " Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" " NOTE: Please see `:h coc-status` for integrations with external plugins
" that
" " provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

set noswapfile
set nohidden
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

nnoremap - :Explore<CR>
" nnoremap - :VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>

nnoremap <c-s> :w<CR> " normal mode: save
inoremap <c-s> <Esc>:w<CR>l " insert mode: escape to normal and save
vnoremap <c-s> <Esc>:w<CR> " visual mode: escape to normal and save

let g:clang_format#auto_format=1

syntax enable
filetype plugin indent on
nnoremap gb :buffers<CR>:buffer<Space>

" colorscheme orbital
