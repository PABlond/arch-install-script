" Matrix colorscheme
" Maintainer: Custom
" Version: 1.0

highlight clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name = "matrix"

" Couleurs de base Matrix (vert doux + jaune + blanc)
highlight Normal guifg=#aaddaa guibg=#141414
highlight Comment guifg=#558855 gui=italic
highlight Constant guifg=#ffff88
highlight String guifg=#aadd88
highlight Identifier guifg=#88cc88
highlight Function guifg=#ccffcc gui=bold
highlight Statement guifg=#ccff88 gui=bold
highlight PreProc guifg=#ffff88
highlight Type guifg=#ccffcc gui=bold
highlight Special guifg=#ffffff
highlight Underlined guifg=#88cc88 gui=underline
highlight Error guifg=#ff4444 guibg=#141414
highlight Todo guifg=#141414 guibg=#ffff88

" UI
highlight LineNr guifg=#335533 guibg=#141414
highlight CursorLine guibg=#001100
highlight CursorLineNr guifg=#88cc88 guibg=#001100 gui=bold
highlight Visual guibg=#224422
highlight Search guifg=#141414 guibg=#ffff88
highlight IncSearch guifg=#141414 guibg=#ffff88
highlight StatusLine guifg=#88cc88 guibg=#1a3320
highlight StatusLineNC guifg=#558855 guibg=#0a1a10
highlight VertSplit guifg=#335533 guibg=#141414
highlight Pmenu guifg=#88cc88 guibg=#0a1a0a
highlight PmenuSel guifg=#141414 guibg=#88cc88
highlight PmenuSbar guibg=#1a3320
highlight PmenuThumb guibg=#88cc88
highlight TabLine guifg=#558855 guibg=#0a1a10
highlight TabLineFill guibg=#141414
highlight TabLineSel guifg=#88cc88 guibg=#1a3320

" Git
highlight DiffAdd guifg=#88cc88 guibg=#0a1a0a
highlight DiffChange guifg=#ffff88 guibg=#1a1a0a
highlight DiffDelete guifg=#cc4444 guibg=#141414
highlight DiffText guifg=#ccffcc guibg=#1a3320

" LSP/Diagnostics
highlight DiagnosticError guifg=#ff6666
highlight DiagnosticWarn guifg=#ffff88
highlight DiagnosticInfo guifg=#88ccff
highlight DiagnosticHint guifg=#88cc88

" Treesitter
highlight @variable guifg=#88cc88
highlight @function guifg=#ccffcc gui=bold
highlight @keyword guifg=#ccff88 gui=bold
highlight @string guifg=#aadd88
highlight @number guifg=#ffff88
highlight @boolean guifg=#ffff88
highlight @comment guifg=#558855 gui=italic
highlight @operator guifg=#ffffff
highlight @punctuation guifg=#aaaaaa
highlight @type guifg=#ccffcc gui=bold
highlight @parameter guifg=#aaddaa

" Illuminate
highlight IlluminatedWordText guifg=#141414 guibg=#88cc88 gui=bold
highlight IlluminatedWordRead guifg=#141414 guibg=#88cc88 gui=bold
highlight IlluminatedWordWrite guifg=#141414 guibg=#aadd88 gui=bold

" NvimTree
highlight NvimTreeNormal guifg=#88cc88 guibg=#141414
highlight NvimTreeFolderName guifg=#88cc88
highlight NvimTreeFolderIcon guifg=#669966
highlight NvimTreeOpenedFolderName guifg=#ccffcc gui=bold
highlight NvimTreeRootFolder guifg=#ccffcc gui=bold

" Telescope
highlight TelescopeNormal guifg=#88cc88 guibg=#141414
highlight TelescopeBorder guifg=#335533
highlight TelescopeSelection guifg=#141414 guibg=#88cc88
highlight TelescopeMatching guifg=#ffff88 gui=bold
