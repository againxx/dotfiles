" This is only necessary if you use set termguicolors.
if !has('nvim')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set termguicolors   " Use gui color (true color) in terminal
" ===
" === Space-vim-dark
" ===
" set background=dark
" colorscheme space-vim-dark

" ===
" === Ayu & One half
" ===
" if exists("$WINDOWID") " Gnome-terminal don't set $WINDOWID
set background=dark
let g:ayucolor = 'mirage'
colorscheme ayu
" else
    " One half
    " colorscheme onehalfdark
" endif

" ===
" === Custom Highlight
" ===
if g:colors_name ==# 'space-vim-dark'
  hi Normal           ctermbg=NONE guibg=NONE
  hi LineNr           ctermbg=NONE guibg=NONE
  hi SignColumn       ctermbg=NONE guibg=NONE
  hi CursorLineNr     ctermbg=NONE guibg=NONE
  hi pythonParam      ctermfg=174 guifg=#d78787 ctermbg=NONE guibg=NONE
  hi pythonSelf       ctermfg=103 guifg=#8787af ctermbg=NONE guibg=NONE
  hi pythonMethod     ctermfg=216 guifg=#ffaf87 ctermbg=NONE guibg=NONE
  " hi pythonMethod     ctermfg=215 guifg=#ffaf5f ctermbg=NONE guibg=NONE
  hi ALEWarning       ctermbg=NONE guibg=NONE
  hi ALEErrorSign     cterm=bold ctermfg=160 ctermbg=NONE gui=bold guifg=#e0211d guibg=NONE
  hi CocHighlightText ctermbg=236 guibg=#34323e
  " hi CocHighlightText ctermbg=237 guibg=#443e51
  " hi Folded           ctermbg=NONE guibg=NONE
endif

if g:colors_name ==# 'ayu'
  hi Normal              ctermbg=NONE guibg=NONE
  hi SignColumn          ctermbg=NONE guibg=NONE
  hi CursorLineNr        ctermbg=NONE guibg=NONE
  hi Comment             cterm=italic gui=italic
  hi ALEWarning          ctermbg=NONE guibg=NONE
  hi Statement           gui=bold,italic
  hi ALEErrorSign        cterm=bold ctermfg=11 ctermbg=NONE gui=bold guifg=#F07178 guibg=NONE
  hi ALEWarningSign      guifg=#E7C547 guibg=NONE
  hi ALEInfoSign         guifg=#95E6CB guibg=NONE
  hi CocErrorSign        cterm=bold ctermfg=11 ctermbg=NONE gui=bold guifg=#F07178 guibg=NONE
  hi CocWarningSign      guifg=#E7C547 guibg=NONE
  hi CocInfoSign         guifg=#95E6CB guibg=NONE
  hi CocHighlightText    guibg=#151A1E
  hi WhiteSpace          guifg=#151A1E
  hi IndentGuidesOdd     ctermbg=NONE guibg=#242F3C
  hi IndentGuidesEven    ctermbg=NONE guibg=#293137
  hi Sneak               guifg=#212733 guibg=#D4BFFF
  hi QuickScopePrimary   guifg=#86B300 gui=underline,bold,italic
  hi QuickScopeSecondary guifg=#36A3D9 gui=underline,bold,italic
  hi MatchParen       gui=underline guifg=#95E6CB
  hi jsonKeyword      guifg=#FFAE57
  hi ColorColumn      guibg=#242F3C
  " hi textSnipTEX      guifg=#FFAE57
  hi! link CocHintHighlight NONE
  let g:VM_Extend_hl = 'CocListBlackCyan'
  let g:VM_Cursor_hl = 'CocListBlackGreen'
  let g:VM_Mono_hl = 'CocListBlackRed'
  " let g:VM_highlight_matches = ''
  " use by indentLine
  hi Conceal guifg=#0F1419
  hi ClapFuzzyMatches1  gui=bold guifg=#D4BFFF
  hi ClapFuzzyMatches2  gui=bold guifg=#C0C2FB
  hi ClapFuzzyMatches3  gui=bold guifg=#ACC4F7
  hi ClapFuzzyMatches4  gui=bold guifg=#98C7F2
  hi ClapFuzzyMatches5  gui=bold guifg=#84CAEE
  hi ClapFuzzyMatches6  gui=bold guifg=#70CCEA
  hi ClapFuzzyMatches7  gui=bold guifg=#5CCFE6
  hi ClapFuzzyMatches8  gui=bold guifg=#59CCD7
  hi ClapFuzzyMatches9  gui=bold guifg=#56C9C7
  hi ClapFuzzyMatches10 gui=bold guifg=#52C5B8
  hi ClapFuzzyMatches11 gui=bold guifg=#4FC2A8
  hi ClapFuzzyMatches12 gui=bold guifg=#4CBF99
  hi VimspectorBP     guifg=#F07178
  hi VimspectorBPCond guifg=#FFAE57
  hi VimspectorPC     guifg=#D4BFFF
  hi VimspectorPCBP   guifg=#D4BFFF
  hi Searchlight      guifg=#FFEE99 guibg=#A37ACC
  hi TSNamespace      guifg=#B8CC52
  hi TSParameter      guifg=#F07178
  hi shCommandSub     guifg=#D4BFFF
  hi! link IncSearchCursor IncSearch
endif

if g:colors_name ==# 'onehalfdark'
  hi Normal                ctermbg=NONE  guibg=NONE
  hi LineNr                ctermbg=NONE  guibg=NONE
  hi SignColumn            ctermbg=NONE  guibg=NONE
  hi CursorLineNr          ctermbg=NONE  guibg=NONE
  hi ALEWarning            ctermbg=NONE  guibg=NONE
  hi GitGutterAdd          ctermbg=NONE  guibg=NONE
  hi GitGutterChange       ctermbg=NONE  guibg=NONE
  hi GitGutterDelete       ctermbg=NONE  guibg=NONE
  hi GitGutterChangeDelete ctermbg=NONE  guibg=NONE
  hi Error                 ctermbg=NONE  guibg=NONE
  hi IndentGuidesOdd       ctermbg=NONE  guibg=#2E3437
  hi IndentGuidesEven      ctermbg=NONE  guibg=#30303C
  hi pythonParam           guifg=#56b6c2 guibg=NONE
  hi CocHighlightText      guibg=#22252C
  " hi IndentGuidesOdd  ctermbg=NONE guibg=#3E4A42
  " hi IndentGuidesEven ctermbg=NONE guibg=#483B56
  " hi IndentGuidesOdd  ctermbg=NONE guibg=#333B3B
  " hi IndentGuidesEven ctermbg=NONE guibg=#383445
endif
