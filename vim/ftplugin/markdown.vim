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
