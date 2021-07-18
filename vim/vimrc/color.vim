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
" === Ayu
" ===
set background=dark
let g:ayucolor = 'mirage'
let g:ayutrans = 1
colorscheme ayu

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
  hi CocHighlightText ctermbg=236 guibg=#34323e
  " hi CocHighlightText ctermbg=237 guibg=#443e51
  " hi Folded           ctermbg=NONE guibg=NONE
endif

if g:colors_name ==# 'ayu'
  hi QuickScopePrimary   guifg=#86B300 gui=underline,bold,italic
  hi QuickScopeSecondary guifg=#399EE6 gui=underline,bold,italic
  hi! link CocHintHighlight NONE
  let g:VM_Extend_hl = 'CocListBlackCyan'
  let g:VM_Cursor_hl = 'CocListBlackGreen'
  let g:VM_Mono_hl = 'CocListBlackRed'
  " let g:VM_highlight_matches = ''
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
  hi Searchlight      guifg=#FFEE99 guibg=#A37ACC
  hi! link shCommandSub    Constant
  hi! link IncSearchCursor IncSearch
  hi! link jsonKeyword     Function
endif
