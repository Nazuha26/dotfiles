highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'mytheme'


" ========== COLORSCHEME ==========

" Line numbers background
highlight LineNr        guifg=#7a7f87 guibg=NONE gui=NONE cterm=NONE term=NONE
highlight LineNrAbove   guifg=#878b94 guibg=NONE gui=NONE cterm=NONE term=NONE
highlight LineNrBelow   guifg=#878b94 guibg=NONE gui=NONE cterm=NONE term=NONE

" Current line number
highlight CursorLineNr guifg=#DCC66A guibg=NONE gui=NONE cterm=NONE term=NONE

" Current line
highlight CursorLine    guifg=NONE guibg=NONE gui=NONE cterm=NONE term=NONE

" Other left columns
highlight SignColumn     guifg=#7a7f87 guibg=NONE gui=NONE
highlight FoldColumn     guifg=#7a7f87 guibg=NONE gui=NONE
highlight CursorLineSign guifg=#7a7f87 guibg=NONE gui=NONE
highlight CursorLineFold guifg=#7a7f87 guibg=NONE gui=NONE

" AUTOCOMPLETE POPUP MENU COLORS
highlight Pmenu      guifg=#cccccc guibg=#373737 gui=NONE
highlight PmenuSel   guifg=#dddddd guibg=#474747 gui=NONE
highlight PmenuSbar  guibg=#303030
highlight PmenuThumb guibg=#575757

" Selection color
highlight Visual    guifg=NONE guibg=#3b3d40 gui=NONE cterm=NONE term=NONE
highlight VisualNOS guifg=NONE guibg=#3b3d40 gui=NONE cterm=NONE term=NONE

" Search highlight
highlight Search    guifg=#BCBEC4 guibg=#165E70 gui=NONE cterm=NONE term=NONE
highlight IncSearch guifg=#BCBEC4 guibg=#1B758B gui=underline cterm=underline term=underline

" Invisible Symbols Highlight
highlight SpecialKey guifg=#525659 guibg=NONE gui=NONE

" LSP diagnostics UNDERLINED
"highlight lscDiagnosticError   guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE gui=undercurl cterm=undercurl term=undercurl guisp=#FA6675
"highlight lscDiagnosticWarning guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE gui=undercurl cterm=undercurl term=undercurl guisp=#F2C55C
"highlight lscDiagnosticInfo    guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE gui=undercurl cterm=undercurl term=undercurl guisp=#3592C4
"highlight lscDiagnosticHint    guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE gui=undercurl cterm=undercurl term=undercurl guisp=#7EC482

" LSP diagnostics BG
highlight lscDiagnosticError   guifg=NONE guibg=#FA6675 ctermfg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
highlight lscDiagnosticWarning guifg=NONE guibg=#F2C55C ctermfg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
highlight lscDiagnosticInfo    guifg=NONE guibg=#3592C4 ctermfg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE
highlight lscDiagnosticHint    guifg=NONE guibg=#7EC482 ctermfg=NONE ctermbg=NONE gui=NONE cterm=NONE term=NONE


highlight lscReference guifg=NONE guibg=#42454a gui=NONE

highlight MatchParen guifg=#ffdf5d guibg=NONE gui=underline cterm=underline term=underline


" GIT GUTTER
highlight GitGutterAdd    guifg=#52d039 guibg=NONE
highlight GitGutterChange guifg=#4185f2 guibg=NONE
highlight GitGutterDelete guifg=#fa6675 guibg=NONE


" STATUSLINE COLORS
highlight StlFilePath    guifg=#dddddd guibg=#555555 gui=NONE
highlight StlFileFlags   guifg=#dddddd guibg=#444444 gui=NONE
highlight StlKeys        guifg=#e0c92f guibg=#444444 gui=NONE
highlight StlEncoding    guifg=#dddddd guibg=#666666 gui=NONE

highlight StlModeNormal  guifg=#1a1a1a guibg=#00b3ff gui=NONE
highlight StlModeInsert  guifg=#1a1a1a guibg=#00e651 gui=NONE
highlight StlModeVisual  guifg=#1a1a1a guibg=#ffe100 gui=NONE
highlight StlModeReplace guifg=#1a1a1a guibg=#ff173a gui=NONE
highlight StlModeCommand guifg=#1a1a1a guibg=#d62ce6 gui=NONE
highlight StlModeMulti   guifg=#1a1a1a guibg=#ff9900 gui=NONE


" ========== BASE COLORS FOR ALL FILETYPES ==========
highlight Normal        guifg=#BCBEC4 guibg=NONE gui=NONE
highlight Underlined    guifg=#BCBEC4 guibg=NONE gui=underline
highlight Comment       guifg=#7A9B68 guibg=NONE gui=NONE
highlight String        guifg=#6aab73 guibg=NONE gui=NONE
highlight Number        guifg=#2aacb8 guibg=NONE gui=NONE
highlight Boolean       guifg=#DCC66A guibg=NONE gui=NONE
highlight Statement     guifg=#DCC66A guibg=NONE gui=bold cterm=bold
highlight Conditional   guifg=#DCC66A guibg=NONE gui=bold cterm=bold
highlight Repeat        guifg=#DCC66A guibg=NONE gui=bold cterm=bold
highlight Keyword       guifg=#DCC66A guibg=NONE gui=bold cterm=bold
highlight Label         guifg=#B86FC6 guibg=NONE gui=NONE
highlight Operator      guifg=#BCBEC4 guibg=NONE gui=NONE
highlight Exception     guifg=#ffa657 guibg=NONE gui=NONE
highlight Include       guifg=#D86F75 guibg=NONE gui=NONE
highlight Type          guifg=#C9824A guibg=NONE gui=NONE
highlight Function      guifg=#6EA6E8 guibg=NONE gui=NONE
highlight Special       guifg=#cf8e6d guibg=NONE gui=NONE
highlight Todo          guifg=#C06AA8 guibg=NONE gui=NONE

" Groups linked to existing groups with same color/style
highlight! link Character     String
highlight! link Float         Number
highlight! link PreProc       Boolean
highlight! link StorageClass  Boolean
highlight! link Structure     Boolean
highlight! link Typedef       Boolean
highlight! link Identifier    Operator
highlight! link Delimiter     Operator
highlight! link Define        Include
highlight! link Macro         Include
highlight! link PreCondit     Include
highlight! link SpecialChar   Special

