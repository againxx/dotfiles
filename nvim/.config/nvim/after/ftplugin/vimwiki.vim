setlocal foldlevel=1
setlocal nowrap
let b:coc_pairs_disabled = ['[', '<']
" Use vimwiki's folding method instead vim-markdown's
let g:vim_markdown_folding_disabled = 1
if !exists('b:key_delay')
  let b:key_delay = 20
endif

call markdown_vimwiki#SetCommonConfigs()

lua require('plenary.filetype').add_file('extra_filetypes')

augroup vimwiki_special
  autocmd!
  autocmd User vim-which-key call which_key#register('gl', 'g:which_wikilist_lower_map')
  autocmd User vim-which-key call which_key#register('gL', 'g:which_wikilist_upper_map')
  " autocmd User visual_multi_start call s:VMStart()
  autocmd User visual_multi_exit  call s:VMExit()
augroup END

if has('nvim')
  nmap <buffer> <M-i> <Plug>VimwikiNextLink
  nmap <buffer> <M-o> <Plug>VimwikiPrevLink
  silent! nunmap <buffer> <Tab>
  silent! nunmap <buffer> <S-Tab>
endif

" unmap automatic list adding
silent! nunmap <buffer> o
silent! nunmap <buffer> O
nnoremap <buffer> gl? <Cmd>WhichKey 'gl'<CR>
nnoremap <buffer> gL? <Cmd>WhichKey 'gL'<CR>
nmap <buffer> glt <Plug>VimwikiRemoveSingleCB
nmap <buffer> gLt <Plug>VimwikiRemoveCBInList
nmap <buffer> <Leader>wD <Plug>VimwikiDeleteFile
nmap <buffer> <Leader>w<Leader>d <Plug>VimwikiDiaryGenerateLinks
nnoremap <buffer> <Leader>tg  <Cmd>lua require('telescope_config').tags()<CR>
nnoremap <buffer> <Leader>ta  <Cmd>TaskWikiAnnotate<CR>
nnoremap <buffer> <Leader>tp  <Cmd>TaskWikiChooseProject<CR>
nnoremap <buffer> <Leader>tt  <Cmd>TaskWikiChooseTag<CR>
nnoremap <buffer> <Leader>tC  <Cmd>TaskWikiCalendar<CR>
nnoremap <buffer> <Leader>td  <Cmd>TaskWikiDone<CR>
nnoremap <buffer> <Leader>tD  <Cmd>TaskWikiDelete<CR>
nnoremap <buffer> <Leader>te  <Cmd>TaskWikiEdit<CR>
nnoremap <buffer> <Leader>thM <Cmd>TaskWikiGhistoryMonthly<CR>
nnoremap <buffer> <Leader>thA <Cmd>TaskWikiGhistoryAnnual<CR>
nnoremap <buffer> <Leader>thm <Cmd>TaskWikiHistoryMonthly<CR>
nnoremap <buffer> <Leader>tha <Cmd>TaskWikiHistoryAnnual<CR>
nnoremap <buffer> <Leader>ti  <Cmd>TaskWikiInfo<CR>
nnoremap <buffer> <Leader>tA  <Cmd>TaskWikiLink<CR>
nnoremap <buffer> <Leader>tm  <Cmd>TaskWikiMod<CR>
nnoremap <buffer> <Leader>tvp <Cmd>TaskWikiProjects<CR>
nnoremap <buffer> <Leader>tvP <Cmd>TaskWikiProjectsSummary<CR>
nnoremap <buffer> <Leader>tvd <Cmd>TaskWikiBurndownDaily<CR>
nnoremap <buffer> <Leader>tvw <Cmd>TaskWikiBurndownWeekly<CR>
nnoremap <buffer> <Leader>tvm <Cmd>TaskWikiBurndownMonthly<CR>
nnoremap <buffer> <Leader>tS  <Cmd>TaskWikiStats<CR>
nnoremap <buffer> <Leader>tG  <Cmd>TaskWikiTags<CR>
nnoremap <buffer> <Leader>t.  <Cmd>TaskWikiRedo<CR>
nnoremap <buffer> <Leader>tb  <Cmd>TaskWikiStart<CR>
nnoremap <buffer> <Leader>tq  <Cmd>TaskWikiStop<CR>
nnoremap <buffer> <Leader>t<C-g> <Cmd>TaskWikiGrid<CR>

" Mappings for visual mode.
vnoremap <silent><buffer> <Space>ta  :TaskWikiAnnotate<CR>
vnoremap <silent><buffer> <Space>tp :TaskWikiChooseProject<CR>
vnoremap <silent><buffer> <Space>tt :TaskWikiChooseTag<CR>
vnoremap <silent><buffer> <Space>td  :TaskWikiDone<CR>
vnoremap <silent><buffer> <Space>tD  :TaskWikiDelete<CR>
vnoremap <silent><buffer> <Space>te  :TaskWikiEdit<CR>
vnoremap <silent><buffer> <Space>ti  :TaskWikiInfo<CR>
vnoremap <silent><buffer> <Space>tA  :TaskWikiLink<CR>
vnoremap <silent><buffer> <Space>tm  :TaskWikiMod<CR>
vnoremap <silent><buffer> <Space>t.  :TaskWikiRedo<CR>
vnoremap <silent><buffer> <Space>tb  :TaskWikiStart<CR>
vnoremap <silent><buffer> <Space>tq  :TaskWikiStop<CR>
vnoremap <silent><buffer> <Space>t<C-g> :TaskWikiGrid<CR>

inoremap <buffer> ;t ::<Space><++><Esc>F:i
if expand('%:e') ==# 'wiki'
  inoremap <buffer> ;b **<Space><++><Esc>F*i
  inoremap <buffer> ;B *__*<Space><++><Esc>F_i
  inoremap <buffer> ;s ~~~~<Space><++><Esc>F~hi
  inoremap <buffer> ;i __<Space><++><Esc>F_i
  inoremap <buffer> ;C {{{<CR>}}}<Esc>ka
  inoremap <buffer> ;p {{<bar><++>}}<Space><++><Esc>F{a
  inoremap <buffer> ;a [[<bar><++>]]<Space><++><Esc>F[a
  inoremap <buffer> ;M {{$<CR>}}$<Esc>kA
  inoremap <buffer> ;r ==<Space>Reference<Space>==<CR><Esc>
  inoremap <buffer> ;1 =<Space><Space>=<Space><++><Esc>F=hi
  inoremap <buffer> ;2 ==<Space><Space>==<Space><++><Esc>F=2hi
  inoremap <buffer> ;3 ===<Space><Space>===<Space><++><Esc>F=3hi
  inoremap <buffer> ;4 ====<Space><Space>====<Space><++><Esc>F=4hi
  " vim-zettel key mappings"
  imap <buffer> <silent> ;z [[<esc><Plug>ZettelSearchMap
  nmap <buffer> gy <Plug>ZettelYankNameMap
  xmap <buffer> gz <Plug>ZettelNewSelectedMap
  nmap <buffer> gZ <Plug>ZettelReplaceFileWithLink

  if executable('xdotool')
    nnoremap <buffer> <Leader>bb :<C-u>call <SID>ControlChromePage('ctrl+r')<CR>
    nnoremap <buffer> <Leader>bj :<C-u>call <SID>ControlChromePage('Down', v:count1)<CR>
    nnoremap <buffer> <Leader>bk :<C-u>call <SID>ControlChromePage('Up', v:count1)<CR>
    nnoremap <buffer> <Leader>bd :<C-u>call <SID>ControlChromePage('Page_Down', v:count1)<CR>
    nnoremap <buffer> <Leader>bu :<C-u>call <SID>ControlChromePage('Page_Up', v:count1)<CR>
    nnoremap <buffer> <Leader>bgg :<C-u>call <SID>ControlChromePage('Home')<CR>
    nnoremap <Leader>cw <Cmd>call <SID>ToggleWikiAutoReload()<CR>
  endif

  command! -buffer -bang -nargs=* Rg call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>),
  \   1, fzf#vim#with_preview({'options': ['--nth', '4..']}), <bang>0
  \ )
endif

function! s:ControlChromePage(key, ...) abort
  let current_window = system('xdotool getactivewindow')[:-2]
  let file_name = expand('%')
  let title =zettel#vimwiki#get_title(file_name)
  if title == ''
    " use the Zettel filename as title if it is empty
    let title = fnamemodify(file_name, ':t:r')
  endif
  let search_pattern = title . '.*(Chrome|Chromium)'
  let target_window = system('xdotool search --onlyvisible --name ' . shellescape(search_pattern))[:-2]
  if target_window != ''
    let key_sequence = [a:key]
    if a:0 > 0
      call extend(key_sequence, repeat([a:key], a:1 - 1))
    endif
    call system('xdotool windowfocus ' . target_window . ' key ' . join(key_sequence))
    execute 'sleep ' . (len(key_sequence) * b:key_delay) . 'm'
    call system('xdotool windowfocus ' . current_window)
  endif
endfunction

function! s:ToggleWikiAutoReload() abort
  let buffer_autocmds = split(execute('autocmd vimwiki_special BufWritePost <buffer>'), '\n')[1:]
  if empty(buffer_autocmds)
    autocmd vimwiki_special BufWritePost <buffer> call s:ControlChromePage('ctrl+r')
    echohl MoreMsg | echo 'Auto reload turned on' | echohl NONE
  else
    autocmd! vimwiki_special BufWritePost <buffer>
    echohl WarningMsg | echo 'Auto reload turned off' | echohl NONE
  endif
endfunction

function! s:VMStart() abort
  nmap <buffer> o <Plug>(VM-Invert-Direction)
endfunction

function! s:VMExit() abort
  " nmap <buffer> o <Plug>VimwikiListo
  imap <buffer> <C-d> <Plug>VimwikiDecreaseLvlSingleItem
  " inoremap <expr><silent><buffer> <CR> pumvisible() ? '<CR>' : '<C-]><Esc>:VimwikiReturn 1 5<CR>'
endfunction
