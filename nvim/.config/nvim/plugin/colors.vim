set termguicolors
set background=dark
let g:ayucolor = 'mirage'
let g:ayutrans = v:true
colorscheme ayu

highlight QuickScopePrimary   guifg=#86B300 gui=underline,bold,italic
highlight QuickScopeSecondary guifg=#399EE6 gui=underline,bold,italic
highlight Searchlight         guifg=#FFEE99 guibg=#A37ACC
highlight LspInlayHint        guifg=#7f709f guibg=NONE
" vim.g.VM_highlight_matches = ''
highlight! link shCommandSub     Constant
highlight! link IncSearchCursor  IncSearch
highlight! link jsonKeyword      Function
" these two highlights will disturb in the hover or documentation floating window
highlight link markdownError NONE
highlight link htmlTagError NONE
highlight link TranslatorBorder DapUIFloatBorder

highlight NeotreeCursorHiddenCursor gui=reverse blend=100
let g:VM_Extend_hl = 'VMExtend'
let g:VM_Cursor_hl = 'VMCursor'
let g:VM_Mono_hl = 'VMMono'
" lua require('colorbuddy').colorscheme('xx.ayu', false, { disable_defaults = true })
