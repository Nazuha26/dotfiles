" BASIC SETTINGS
syntax on
filetype plugin indent on

set mouse=a
set clipboard=unnamedplus
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



" THIN CURSOR IN INSERT MODE & BLOCK IN NORMAL MODE
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


" AUTOCOMPLETE MENU BEHAVIOR
set completeopt=menu,menuone,noinsert


" PLUGINS MANAGEMENT
call plug#begin('~/.vim/plugged')
Plug 'natebosch/vim-lsc'
Plug 'bfrg/vim-cpp-modern'
call plug#end()


" LSP AND CLANGD CONFIGURATION
let g:lsc_server_commands = {
  \ 'c': 'clangd --log=error',
  \ 'cpp': 'clangd --log=error'
  \ }

" ENABLE AUTOCOMPLETE
let g:lsc_auto_complete = v:true
  

let g:cpp_member_highlight = 1
let g:cpp_function_highlight = 1
let g:cpp_attributes_highlight = 1


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

" VISUAL BLOCK
nnoremap <C-b> <C-v>

" COPY
vnoremap <C-c> "+y

" CUT
vnoremap <C-x> "+d

" PASTE
nnoremap <C-v> "+p
inoremap <C-v> <C-r>+
cnoremap <C-v> <C-r>+
vnoremap <C-v> "-d"+P

" SELECT ALL
nnoremap <C-a> ggVG
inoremap <C-a> <Esc>ggVG
vnoremap <C-a> <Esc>ggVG

" MOVE SELECTED LINES UP/DOWN
nnoremap <C-S-Up> :m .-2<CR>==
nnoremap <C-S-Down> :m .+1<CR>==
vnoremap <C-S-Up> :m '<-2<CR>gv=gv
vnoremap <C-S-Down> :m '>+1<CR>gv=gv

" --- DEV ---
" Get syntax group under the cursor (for colorscheme)
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

function! SynStack() abort
  for id in synstack(line('.'), col('.'))
    echo synIDattr(id, 'name') . ' -> ' . synIDattr(synIDtrans(id), 'name')
  endfor
endfunction

command! SynStack call SynStack()
nnoremap <F11> :SynStack<CR>




" ========== COLORSCHEME ==========
" Line numbers background
highlight LineNr        guifg=#7a7f87 guibg=#202226 gui=NONE cterm=NONE term=NONE
highlight LineNrAbove   guifg=#878b94 guibg=#202226 gui=NONE cterm=NONE term=NONE
highlight LineNrBelow   guifg=#878b94 guibg=#202226 gui=NONE cterm=NONE term=NONE

" Current line number
highlight CursorLineNr guifg=#e0c92f guibg=#26292d gui=NONE cterm=NONE term=NONE

" Current line
highlight CursorLine    guifg=NONE guibg=NONE gui=NONE cterm=NONE term=NONE

" Other left columns
highlight SignColumn       guifg=#7a7f87 guibg=#202226 gui=NONE
highlight FoldColumn       guifg=#7a7f87 guibg=#202226 gui=NONE
highlight CursorLineSign   guifg=#7a7f87 guibg=#202226 gui=NONE
highlight CursorLineFold   guifg=#7a7f87 guibg=#202226 gui=NONE

" AUTOCOMPLETE POPUP MENU COLORS
highlight Pmenu guifg=#cccccc guibg=#373737 gui=NONE
highlight PmenuSel guifg=#dddddd guibg=#474747 gui=NONE
highlight PmenuSbar guibg=#303030
highlight PmenuThumb guibg=#575757

" Selection color
highlight Visual guifg=NONE guibg=#3b3d40 gui=NONE

" LSP Errors
highlight lscDiagnosticError guifg=NONE guibg=#ba2736 gui=underline cterm=underline term=underline

highlight lscReference guifg=NONE guibg=#42454a gui=NONE

" Default code text
highlight Normal guifg=#BCBEC4 guibg=NONE gui=NONE

highlight MatchParen guifg=#424242 guibg=#dbb81a gui=underline cterm=underline term=underline


" ========== C lang ==========
" Base Vim C groups
highlight cStatement guifg=#ffdf5d gui=NONE
highlight cLabel guifg=#d63dc9 gui=NONE
highlight cConditional guifg=#ffdf5d gui=NONE
highlight cRepeat guifg=#ffdf5d gui=NONE
highlight cOperator guifg=#ffdf5d gui=NONE
highlight cType guifg=#df7326 gui=NONE
highlight cStorageClass guifg=#ffdf5d gui=NONE
highlight cStructure guifg=#ffdf5d gui=NONE
highlight cTypedef guifg=#ffdf5d gui=NONE
highlight cConstant guifg=#ffdf5d gui=NONE

" Comments
highlight Comment guifg=#52d039 gui=NONE
highlight cComment guifg=#52d039 gui=NONE
highlight cCommentL guifg=#52d039 gui=NONE
highlight cTodo guifg=#d039a8 gui=NONE

" Strings / chars
highlight cString guifg=#6aab73 gui=NONE
highlight cCharacter guifg=#6aab73 gui=NONE
highlight cSpecial guifg=#cf8e6d gui=NONE
highlight cSpecialCharacter guifg=#6aab73 gui=NONE
highlight cFormat guifg=#ffdf5d gui=NONE
highlight cIncluded guifg=#6aab73 gui=NONE

" Numbers
highlight cNumber guifg=#2aacb8 gui=NONE
highlight cFloat guifg=#2aacb8 gui=NONE
highlight cOctal guifg=#2aacb8 gui=NONE

" Preprocessor
highlight cInclude guifg=#fa6675 gui=NONE
highlight cPreProc guifg=#ffdf5d gui=NONE
highlight cDefine guifg=#fa6675 gui=NONE
highlight cPreCondit guifg=#fa6675 gui=NONE

" Functions
highlight Function guifg=#509bed gui=NONE
highlight cFunction guifg=#509bed gui=NONE
highlight cFunctionPointer guifg=#509bed gui=NONE
highlight cUserFunction guifg=#509bed gui=NONE
highlight cUserFunctionPointer guifg=#509bed gui=NONE

" Members / type names / builtins
highlight cMemberAccess guifg=NONE gui=NONE
highlight cStructMember guifg=#ac79be gui=NONE
highlight cTypeName guifg=#df7326 gui=NONE
highlight cBoolean guifg=#ffdf5d gui=NONE
highlight cAnsiName guifg=#bababa gui=NONE
highlight cBuiltinType guifg=#df7326 gui=NONE

" Errors
highlight cError guifg=#fa6675 gui=NONE
highlight cOctalError guifg=#fa6675 gui=NONE
highlight cParenError guifg=#fa6675 gui=NONE
highlight cErrInParen guifg=#fa6675 gui=NONE
highlight cErrInBracket guifg=#fa6675 gui=NONE
highlight cCommentError guifg=#fa6675 gui=NONE
highlight cCommentStartError guifg=#fa6675 gui=NONE
highlight cSpaceError guifg=#fa6675 gui=NONE
highlight cWrongComTail guifg=#fa6675 gui=NONE
highlight cSpecialError guifg=#fa6675 gui=NONE
highlight cCurlyError guifg=#fa6675 gui=NONE

" Base Vim C++ groups
highlight cppStatement guifg=#ffdf5d gui=NONE
highlight cppAccess guifg=#ffdf5d gui=NONE
highlight cppCast guifg=#d2a8ff gui=NONE
highlight cppExceptions guifg=#ffa657 gui=NONE
highlight cppOperator guifg=#ffdf5d gui=NONE
highlight cppModifier guifg=#ffdf5d gui=NONE
highlight cppType guifg=#df7326 gui=NONE
highlight cppStorageClass guifg=#f2cc60 gui=NONE
highlight cppStructure guifg=#1538e5 gui=NONE
highlight cppBoolean guifg=#df7326 gui=NONE
highlight cppConstant guifg=#a5d6ff gui=NONE
highlight cppString guifg=#6aab73 gui=NONE
highlight cppRawString guifg=#6aab73 gui=NONE
highlight cppRawStringDelimiter guifg=#6aab73 gui=NONE
highlight cppCharacter guifg=#6aab73 gui=NONE
highlight cppSpecialCharacter guifg=#cf8e6d gui=NONE
highlight cppSpecialError guifg=#cf8e6d gui=NONE
highlight cppNumber guifg=#2aacb8 gui=NONE
highlight cppFloat guifg=#2aacb8 gui=NONE
highlight cppModule guifg=#fa6675 gui=NONE

" vim-c-cpp-modern: attributes / templates
highlight cppAttribute guifg=#fa6675 gui=NONE
highlight cppAttributeBrackets guifg=#bababa gui=NONE
highlight cppTemplateKeyword guifg=#ffdf5d gui=NONE
highlight cppBuiltinType guifg=#df7326 gui=NONE

" vim-c-cpp-modern: STL / std
highlight cppSTLdefine guifg=#fa6675 gui=NONE
highlight cppSTLnamespace guifg=#bababa gui=NONE
highlight cppSTLconstant guifg=#ffdf5d gui=NONE
highlight cppSTLvariable guifg=#df7326 gui=NONE
highlight cppSTLexception guifg=#df7326 gui=NONE
highlight cppSTLios guifg=#509bed gui=NONE
highlight cppSTLtype guifg=#df7326 gui=NONE
highlight cppSTLtypedef guifg=#df7326 gui=NONE
highlight cppSTLiterator guifg=#df7326 gui=NONE
highlight cppSTLfunction guifg=#509bed gui=NONE
highlight cppSTLbool guifg=#ffdf5d gui=NONE
highlight cppSTLenum guifg=#df7326 gui=NONE
highlight cppSTLconcept guifg=#df7326 gui=NONE
