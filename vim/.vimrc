" BASIC SETTINGS
syntax on
filetype plugin indent on

set mouse=a
set termguicolors
set noshowmode

set ttimeout
set ttimeoutlen=50



" LINE NUMBER COLUMN
set number
set relativenumber
set numberwidth=4

" Highlight only current line number, not whole text line
set cursorline
set cursorlineopt=number

" Line numbers background
highlight LineNr        guifg=#7a7f87 guibg=#202226 gui=NONE cterm=NONE term=NONE
highlight LineNrAbove   guifg=#878b94 guibg=#202226 gui=NONE cterm=NONE term=NONE
highlight LineNrBelow   guifg=#878b94 guibg=#202226 gui=NONE cterm=NONE term=NONE

" Current line number
highlight CursorLineNr guifg=#e0c92f guibg=#26292d gui=bold cterm=bold term=bold

" Current line
highlight CursorLine    guifg=NONE guibg=NONE gui=NONE cterm=NONE term=NONE

" Other left columns
highlight SignColumn       guifg=#7a7f87 guibg=#202226 gui=NONE
highlight FoldColumn       guifg=#7a7f87 guibg=#202226 gui=NONE
highlight CursorLineSign   guifg=#7a7f87 guibg=#202226 gui=NONE
highlight CursorLineFold   guifg=#7a7f87 guibg=#202226 gui=NONE



" THIN CURSOR IN INSERT MODE & BLOCK IN NORMAL MODE
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


" AUTOCOMPLETE MENU BEHAVIOR
set completeopt=menu,menuone,noinsert


" PLUGINS MANAGEMENT
call plug#begin('~/.vim/plugged')
Plug 'natebosch/vim-lsc'
call plug#end()


" LSP AND CLANGD CONFIGURATION
let g:lsc_server_commands = {
  \ 'c': 'clangd --log=error',
  \ 'cpp': 'clangd --log=error'
  \ }



" ENABLE AUTOCOMPLETE
let g:lsc_auto_complete = v:true



" STATUSLINE COLORS
highlight StlFilePath    guifg=#dddddd guibg=#555555 gui=NONE
highlight StlFileFlags   guifg=#dddddd guibg=#444444 gui=NONE
highlight StlEncoding    guifg=#dddddd guibg=#666666 gui=NONE

highlight StlModeNormal  guifg=#1a1a1a guibg=#00b3ff gui=NONE
highlight StlModeInsert  guifg=#1a1a1a guibg=#00e651 gui=NONE
highlight StlModeVisual  guifg=#1a1a1a guibg=#ffe100 gui=NONE
highlight StlModeReplace guifg=#1a1a1a guibg=#ff173a gui=NONE
highlight StlModeCommand guifg=#1a1a1a guibg=#d62ce6 gui=NONE

function! ModeBlock() abort
  let l:m = mode(1)

  if l:m =~# '^c'
    return '%#StlModeCommand#  COMMAND  '
  endif

  if l:m =~# '^i'
    return '%#StlModeInsert#  INSERT  '
  endif

  if l:m ==# 'v' || l:m ==# 'V' || l:m ==# "\<C-V>"
    return '%#StlModeVisual#  VISUAL  '
  endif

  if l:m =~# '^R'
    return '%#StlModeReplace#  REPLACE  '
  endif

  return '%#StlModeNormal#  NORMAL  '
endfunction

function! MyStatusLine() abort
  return
        \ '%#StlFilePath# %F ' .
        \ '%#StlFileFlags# %m' .
        \ '%#StlFileFlags#%r' .
        \ '%#StlFileFlags#%=' .
        \ '%#StlFilePath#  Ln %l, Col %c  ' .
        \ '%#StlEncoding# %{&fileencoding?&fileencoding:&encoding} ' .
        \ ModeBlock()
endfunction

set laststatus=2
set statusline=%!MyStatusLine()

augroup StatuslineRedraw
  autocmd!
  autocmd ModeChanged * redrawstatus
  autocmd CmdlineEnter,CmdlineLeave * redrawstatus
augroup END



" ===== HOTKEYS MAPPING =====

" SCROLL WITH CTRL + ARROWS
nnoremap <C-Up>   <C-y>
nnoremap <C-Down> <C-e>
nnoremap <C-k>    <C-y>
nnoremap <C-j>    <C-e>

" QUIT
nnoremap <C-q> :confirm q<CR>

" SAVE
nnoremap <C-s> :w<CR>

" UNDO
nnoremap <C-z> :undo<CR>
inoremap <C-z> <C-o>:undo<CR>

" REDO
nnoremap <C-y> :redo<CR>
inoremap <C-y> <C-o>:redo<CR>
" For terminals which can intercept Ctrl+Shift+Z
"nnoremap <C-S-z> :redo<CR>
"inoremap <C-S-z> <C-o>:redo<CR>
