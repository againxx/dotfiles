" Author: againxx <againxx@mail.ustc.edu.cn>
" Description: Clap theme based on the ayu theme.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:palette = {}

let s:palette.display = { 'guibg': '#1F2430' }

" Let ClapInput, ClapSpinner and ClapSearchText use the same background.
let s:bg0 = { 'guibg': '#232834' }
let s:palette.input = s:bg0
let s:palette.indicator = extend({ 'guifg':'#707A8C' }, s:bg0)
let s:palette.spinner = extend({ 'guifg':'#FFB454', 'gui': 'bold'}, s:bg0)
let s:palette.search_text = extend({ 'guifg': '#FFEE99', 'gui': 'bold' }, s:bg0)

let s:palette.preview = { 'guibg': '#33415E' }

let s:palette.selected = { 'guifg': '#73D0FF', 'gui': 'bold,underline' }
let s:palette.current_selection = { 'guibg': '#101521', 'gui': 'bold' }

let s:palette.selected_sign = { 'guifg': '#D4BFFF' }
let s:palette.current_selection_sign = { 'guifg': '#F28779' }

let g:clap#themes#ayu#palette = s:palette

let &cpoptions = s:save_cpo
unlet s:save_cpo
