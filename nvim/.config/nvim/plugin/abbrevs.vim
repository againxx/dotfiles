iabbrev slef self
iabbrev thsi this
iabbrev previos previous
iabbrev pritn print
iabbrev flase false
iabbrev Flase False
iabbrev ture true
iabbrev Ture True
iabbrev asycn async
iabbrev raod road

cabbrev raod road
" superman
cabbrev man <c-r>=getcmdpos() == 1 && getcmdtype() == ':' ? 'Man' : 'man'<CR>
