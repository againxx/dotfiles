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
" let g:airline_theme = 'violet'

" ===
" === Ayu & One half
" ===
" if exists("$WINDOWID") " Gnome-terminal don't set $WINDOWID
set background=dark
let g:ayucolor = 'mirage'
colorscheme ayu
let g:airline_theme = 'ayu_mirage'
" else
    " One half
    " colorscheme onehalfdark
    " let g:airline_theme = 'onehalfdark'
" endif

" ===
" === Custom Highlight
" ===
if g:colors_name == 'space-vim-dark'
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

if g:colors_name == 'ayu'
    hi Normal           ctermbg=NONE guibg=NONE
    hi SignColumn       ctermbg=NONE guibg=NONE
    hi CursorLineNr     ctermbg=NONE guibg=NONE
    hi Comment          cterm=italic gui=italic
    hi ALEWarning       ctermbg=NONE guibg=NONE
    hi pythonSelf       gui=italic guifg=#A37ACC guibg=NONE
    hi pythonParam      guifg=#F07178 guibg=NONE
    hi pythonInclude    gui=bold,italic guifg=#FFC44C
    hi Statement        gui=bold,italic
    hi ALEErrorSign     cterm=bold ctermfg=11 ctermbg=NONE gui=bold guifg=#F07178 guibg=NONE
    hi ALEWarningSign   guifg=#E7C547 guibg=NONE
    hi ALEInfoSign      guifg=#95E6CB guibg=NONE
    hi CocHighlightText guibg=#151A1E
    hi IndentGuidesOdd  ctermbg=NONE guibg=#242F3C
    hi IndentGuidesEven ctermbg=NONE guibg=#293137
    hi Sneak            guifg=#212733 guibg=#D4BFFF
    hi QuickScopePrimary guifg='#86B300' gui=underline,bold,italic
    hi QuickScopeSecondary guifg='#36A3D9' gui=underline,bold,italic
    " vim-markdown
    hi htmlH1           gui=bold guifg=#D4BFFF guibg=NONE
    hi htmlH2           gui=bold guifg=#BBE67E guibg=NONE
    hi htmlH3           gui=bold guifg=#5CCFE6 guibg=NONE
    hi htmlH4           gui=bold guifg=#FFAE57 guibg=NONE
    hi htmlH5           guifg=#F07178 guibg=NONE
    hi htmlH6           guifg=#95E6CB guibg=NONE
    hi MatchParen       gui=underline guifg=#95E6CB
    hi jsonKeyword      guifg=#FFAE57
    " hi pythonMethod     guifg=#ffaf87 guibg=NONE
    hi! link Conceal Function
    hi! link pythonDocstring pythonComment
    let g:VM_Extend_hl = 'CocListBlackCyan'
    let g:VM_highlight_matches = ''
endif

if g:colors_name == 'onehalfdark'
    hi Normal                ctermbg=NONE    guibg=NONE
    hi LineNr                ctermbg=NONE    guibg=NONE
    hi SignColumn            ctermbg=NONE    guibg=NONE
    hi CursorLineNr          ctermbg=NONE    guibg=NONE
    hi ALEWarning            ctermbg=NONE    guibg=NONE
    hi GitGutterAdd          ctermbg=NONE    guibg=NONE
    hi GitGutterChange       ctermbg=NONE    guibg=NONE
    hi GitGutterDelete       ctermbg=NONE    guibg=NONE
    hi GitGutterChangeDelete ctermbg=NONE    guibg=NONE
    hi Error                 ctermbg=NONE    guibg=NONE
    hi IndentGuidesOdd       ctermbg=NONE    guibg=#2E3437
    hi IndentGuidesEven      ctermbg=NONE    guibg=#30303C
    hi CocHighlightText        guibg=#22252C
    hi pythonParam             guifg=#56b6c2 guibg=NONE
    " hi IndentGuidesOdd  ctermbg=NONE guibg=#3E4A42
    " hi IndentGuidesEven ctermbg=NONE guibg=#483B56
    " hi IndentGuidesOdd  ctermbg=NONE guibg=#333B3B
    " hi IndentGuidesEven ctermbg=NONE guibg=#383445
endif
