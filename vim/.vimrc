" BASIC SETTINGS
let mapleader = " "
set mouse=a
 
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
set whichwrap+=<,>,h,l,[,]

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


" Vim state directories
for s:dir in ['~/.vim/backup', '~/.vim/swap', '~/.vim/undo']
  silent! call mkdir(expand(s:dir), 'p')
endfor
unlet s:dir

set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo//
endif


" vim-visual-multi settings must be defined before plugin mappings are initialized
let g:VM_set_statusline = 0
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
let g:VM_maps["Add Cursor Up"]   = '<M-Up>'
let g:VM_insert_special_keys = []

 
" PLUGINS MANAGEMENT
call plug#begin('~/.vim/plugged')
Plug 'natebosch/vim-lsc'
Plug 'bfrg/vim-cpp-modern'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'airblade/vim-gitgutter'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
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
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"

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

" vim-which-key SETTINGS
let g:which_key_map = {}
let g:which_key_display_names = {' ': 'Space'} "

let g:which_key_map['f'] = 'Format C/C++ code'
let g:which_key_map[' '] = 'Clear search highlight'

let g:which_key_map['h'] = {
      \ 'name' : '+Git Hunks' ,
      \ 'p' : 'Preview hunk' ,
      \ 's' : 'Stage hunk' ,
      \ 'u' : 'Undo hunk' ,
      \ }

call which_key#register('<Space>', "g:which_key_map")



" Toggle (Show-Hide) invisible symbols: tabs, spaces, trails
set listchars=tab:→\ ,space:·,trail:·
set list


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
        \ '%#StlFilePath# (%l, %c) ' .
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


" ===== STARTIFY =====
set shortmess+=I

let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks:'] },
      \ ]

let g:startify_bookmarks = [
      \ {'v': '~/.vimrc'},
      \ {'t': '~/.vim/colors/mytheme.vim'},
      \ ]

function! CurrentVimVersion() abort
  let l:major = v:version / 100
  let l:minor = v:version % 100

  if exists('v:versionlong')
    let l:patch = v:versionlong % 10000
    return printf('%d.%d.%d', l:major, l:minor, l:patch)
  endif

  return printf('%d.%d', l:major, l:minor)
endfunction

function! StartifyHeader() abort
  let l:logo = [
        \ ' ____   ____ __          ',
        \ ' \   \ /   /|__| _____   ',
        \ '  \   Y   / |  |/     \  ',
        \ '   \     /  |  |  Y Y  \ ',
        \ '    \___/   |__|__|_|  / ',
        \ '                     \/  ',
        \ '',
        \ ' ======= ' . CurrentVimVersion() . ' ======= ',
        \ '',
        \ ]

  return startify#center(l:logo)
endfunction

let g:startify_custom_header = 'StartifyHeader()'

let g:startify_change_to_dir = 1


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

" vim-which-key
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>


" COPY / CUT / PASTE through Lemonade or system clipboard
function! HasNativeClipboard() abort
  return has('clipboard') && (!has('unix') || !empty($DISPLAY) || !empty($WAYLAND_DISPLAY))
endfunction

function! HostClipboardText() abort
  if executable('lemonade')
    let l:text = system('lemonade paste')
  elseif HasNativeClipboard()
    let l:text = getreg('+')
  else
    let l:text = getreg('"')
  endif

  let l:text = substitute(l:text, '\r\n', "\n", 'g')
  let l:text = substitute(l:text, '\r', "\n", 'g')
  return l:text
endfunction

function! HostClipboardCopy(text) abort
  if executable('lemonade')
    call system('lemonade copy', a:text)
  elseif HasNativeClipboard()
    call setreg('+', a:text, 'v')
  else
    call setreg('"', a:text, 'v')
  endif
endfunction

function! HostLoadPasteRegister() abort
  let l:text = HostClipboardText()

  call setreg('z', l:text, 'v')
  call setreg('"', l:text, 'v')

  if HasNativeClipboard()
    call setreg('+', l:text, 'v')
  endif

  return l:text
endfunction

function! IsVMActive() abort
  return exists('*VMInfos') && !empty(VMInfos())
endfunction

function! HostPasteInsertExpr() abort
  call HostLoadPasteRegister()

  if IsVMActive()
    return "\<C-r>z"
  endif
 
  return "\<C-r>\<C-o>z\<C-o>']"
endfunction

function! HostCopyVisual() abort
  normal! gv"zy
  call HostClipboardCopy(getreg('z'))
endfunction

function! HostCutVisual() abort
  normal! gv"zd
  call HostClipboardCopy(getreg('z'))
endfunction
 
function! HostPasteAfter() abort
  let l:save_paste = &paste
  set paste
  call HostLoadPasteRegister()
  normal! "zp
  silent! normal! ']
  let &paste = l:save_paste
endfunction

function! HostPasteReplaceVisual() abort
  let l:save_paste = &paste
  set paste
  call HostLoadPasteRegister()
  normal! gv"_d
  normal! "zP
  silent! normal! ']
  let &paste = l:save_paste
endfunction

" Copy / cut selected text
xnoremap <C-c> :<C-u>call HostCopyVisual()<CR>
xnoremap <C-x> :<C-u>call HostCutVisual()<CR>

" Paste
nnoremap <C-v> :<C-u>call HostPasteAfter()<CR>
xnoremap <C-v> :<C-u>call HostPasteReplaceVisual()<CR>
inoremap <silent><expr> <C-v> HostPasteInsertExpr()
cnoremap <C-v> <C-r>=HostClipboardText()<CR>



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

