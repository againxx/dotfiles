let b:coc_pairs_disabled = ['<']
let g:vim_markdown_folding_disabled = 0
let g:sneak#label = 0 | call sneak#init()
" one or two spaces aren't considered as trailing
let b:lightline_whitespace_trailing_regexp = '\( \{3,}\|\t\)$'

call markdown_vimwiki#SetCommonConfigs()

nmap <buffer> [h <Plug>Markdown_MoveToCurHeader
inoremap <buffer> ;b ****<Space><++><Esc>F*hi
inoremap <buffer> ;s ~~~~<Space><++><Esc>F~hi
inoremap <buffer> ;i **<Space><++><Esc>F*i
inoremap <buffer> ;C ```<CR>```<Esc>ka
inoremap <buffer> ;p ![](<++>)<Space><++><Esc>F[a
inoremap <buffer> ;a [](<++>)<Space><++><Esc>F[a
inoremap <buffer> ;r ##<Space>Reference<CR><Esc>
inoremap <buffer> ;M $$<CR>$$<Esc>O
inoremap <buffer> ;1 #<Space>
inoremap <buffer> ;2 ##<Space>
inoremap <buffer> ;3 ###<Space>
inoremap <buffer> ;4 ####<Space>

if g:colors_name ==# 'ayu'
  hi htmlH1           gui=bold guifg=#D4BFFF guibg=NONE
  hi htmlH2           gui=bold guifg=#BBE67E guibg=NONE
  hi htmlH3           gui=bold guifg=#5CCFE6 guibg=NONE
  hi htmlH4           gui=bold guifg=#FFAE57 guibg=NONE
  hi htmlH5           guifg=#F07178 guibg=NONE
  hi htmlH6           guifg=#95E6CB guibg=NONE
endif
