" BASIC SETTINGS
let mapleader = " "
set mouse=a
set clipboard=unnamedplus

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent

set noshowmode
set showcmd
set showcmdloc=statusline

set ttimeout
set ttimeoutlen=50

set termguicolors
" Terminal undercurl / underline color support
let &t_Cs = "\<Esc>[4:3m"
let &t_Ce = "\<Esc>[4:0m\<Esc>[59m"
let &t_8u = "\<Esc>[58:2::%lu:%lu:%lum"


" PLUGINS MANAGEMENT
call plug#begin('~/.vim/plugged')
Plug 'natebosch/vim-lsc'
Plug 'bfrg/vim-cpp-modern'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
call plug#end()

syntax on
filetype plugin indent on

" COLORSCHEME
colorscheme mytheme


" LINE NUMBER COLUMN
set number
set relativenumber
set numberwidth=4

" Highlight only current line number, not whole text line
set cursorline
set cursorlineopt=number

" THIN CURSOR IN INSERT MODE & BLOCK IN NORMAL MODE
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" AUTOCOMPLETE MENU BEHAVIOR
set completeopt=menu,menuone,noinsert

" LSP AND CLANGD CONFIGURATION
let g:lsc_server_commands = {
  \ 'c': 'clangd --log=error',
  \ 'cpp': 'clangd --log=error'
  \ }

" ENABLE AUTOCOMPLETE
let g:lsc_enable_autocomplete = v:true
  
" C lang settings
let g:cpp_member_highlight = 1
let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1


" MULTICURSOR (vim-visual-multi)
let g:VM_set_statusline = 0
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
let g:VM_maps["Add Cursor Up"]   = '<M-Up>'


" GIT GUTTER
set signcolumn=yes
set updatetime=100

let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '_'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed = '│'



" SEARCH SETTINGS
set hlsearch
set incsearch
set ignorecase
set smartcase
silent! nohlsearch



function! ModeBlock() abort
  if exists('*VMInfos')
    let l:vm = VMInfos()
    if !empty(l:vm)
      return '%#StlModeMulti#  MULTIC  '
    endif
  endif
  
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
        \ '%#StlKeys# %S ' .
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
inoremap <C-s> <Esc>:w<CR>
vnoremap <C-s> <Esc>:w<CR>

" UNDO
nnoremap <C-z> :undo<CR>
inoremap <C-z> <C-o>:undo<CR>

" REDO
" Ctrl+Shift+Z from WezTerm sends: \x1b[24u
execute "set <F24>=\e[24u"

nnoremap <F24> :redo<CR>
inoremap <F24> <C-o>:redo<CR>
xnoremap <F24> <Esc>:redo<CR>
" For terminals which can intercept Ctrl+Shift+Z
" nnoremap <C-S-z> :redo<CR>
" inoremap <C-S-z> <C-o>:redo<CR>

" VISUAL BLOCK
nnoremap <C-b> <C-v>


" COPY / CUT / PASTE through Lemonade
if executable('lemonade')

  function! LemonadeGetText() abort
    let l:text = system('lemonade paste')
    let l:text = substitute(l:text, '\r\n', "\n", 'g')
    let l:text = substitute(l:text, '\r', "\n", 'g')
    return l:text
  endfunction

  function! LemonadeCopyVisual() abort
    normal! gv"zy
    call system('lemonade copy', getreg('z'))
  endfunction

  function! LemonadeCutVisual() abort
    normal! gv"zd
    call system('lemonade copy', getreg('z'))
  endfunction

  function! LemonadePasteAfter() abort
    let l:save_paste = &paste
    set paste
    call setreg('z', LemonadeGetText(), 'v')
    normal! "zp
    let &paste = l:save_paste
  endfunction

  function! LemonadePasteBefore() abort
    let l:save_paste = &paste
    set paste
    call setreg('z', LemonadeGetText(), 'v')
    normal! "zP
    let &paste = l:save_paste
  endfunction

  function! LemonadePasteReplaceVisual() abort
    let l:save_paste = &paste
    set paste
    call setreg('z', LemonadeGetText(), 'v')
    normal! gv"_d
    normal! "zP
    let &paste = l:save_paste
  endfunction

  " Copy / cut selected text
  xnoremap <C-c> :<C-u>call LemonadeCopyVisual()<CR>
  xnoremap <C-x> :<C-u>call LemonadeCutVisual()<CR>

  " Paste
  nnoremap <C-v> :<C-u>call LemonadePasteAfter()<CR>
  xnoremap <C-v> :<C-u>call LemonadePasteReplaceVisual()<CR>
  inoremap <C-v> <Esc>:<C-u>call LemonadePasteAfter()<CR>a
  cnoremap <C-v> <C-r>=system('lemonade paste')<CR>

else

  " COPY
  vnoremap <C-c> "+y

  " CUT
  vnoremap <C-x> "+d

  " PASTE
  nnoremap <C-v> "+p
  inoremap <C-v> <C-r>+
  cnoremap <C-v> <C-r>+
  vnoremap <C-v> "-d"+P

endif


" SELECT ALL
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG
vnoremap <C-a> <Esc>ggVG

" MOVE SELECTED LINES UP/DOWN
nnoremap <C-S-Up> :m .-2<CR>==
nnoremap <C-S-Down> :m .+1<CR>==
vnoremap <C-S-Up> :m '<-2<CR>gv=gv
vnoremap <C-S-Down> :m '>+1<CR>gv=gv

" CLEAR SEARCH RESULT
nnoremap <leader><leader> :nohlsearch<CR>

" FORMATTING
nnoremap <leader>f :%!clang-format --style=file --assume-filename=%:p<CR>

