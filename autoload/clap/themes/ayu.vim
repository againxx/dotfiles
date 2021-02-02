" Author: againxx <againxx@mail.ustc.edu.cn>
" Description: Clap theme based on the ayu theme.

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:palette = {}

let s:palette.display = { 'guibg': '#212733' }

" Let ClapInput, ClapSpinner and ClapSearchText use the same background.
let s:bg0 = { 'guibg': '#272D38' }
let s:palette.input = s:bg0
let s:palette.indicator = extend({ 'guifg':'#607080' }, s:bg0)
let s:palette.spinner = extend({ 'guifg':'#FFCC66', 'gui': 'bold'}, s:bg0)
let s:palette.search_text = extend({ 'guifg': '#FFEE99', 'gui': 'bold' }, s:bg0)

let s:palette.preview = { 'guibg': '#343F4C' }

let s:palette.selected = { 'guifg': '#5CCFE6', 'gui': 'bold,underline' }
let s:palette.current_selection = { 'guibg': '#151A1E', 'gui': 'bold' }

let s:palette.selected_sign = { 'guifg': '#D4BFFF' }
let s:palette.current_selection_sign = { 'guifg': '#F07178' }

let g:clap#themes#ayu#palette = s:palette

let &cpoptions = s:save_cpo
unlet s:save_cpo
