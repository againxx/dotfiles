setlocal foldlevel=1
setlocal nowrap
let b:coc_pairs_disabled = ['[', '<']
" VimwikiSearchTags will use locallist, disable ale to avoid conflict
" let b:ale_enabled = 0
" Use vimwiki's folding method instead vim-markdown's
let g:vim_markdown_folding_disabled = 1
if !exists('b:key_delay')
  let b:key_delay = 20
endif

call markdown_vimwiki#SetCommonConfigs()

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
nnoremap <silent><buffer> gl? :<C-u>WhichKey 'gl'<CR>
nnoremap <silent><buffer> gL? :<C-u>WhichKey 'gL'<CR>
nmap <buffer> glt <Plug>VimwikiRemoveSingleCB
nmap <buffer> gLt <Plug>VimwikiRemoveCBInList
nmap <buffer> <Leader>wD <Plug>VimwikiDeleteFile
nmap <buffer> <Leader>w<Leader>d <Plug>VimwikiDiaryGenerateLinks
nnoremap <silent><buffer> <Space>tg  :<C-u>Tags<cr>
nnoremap <silent><buffer> <Space>ta  :TaskWikiAnnotate<CR>
nnoremap <silent><buffer> <Space>tp :TaskWikiChooseProject<CR>
nnoremap <silent><buffer> <Space>tt :TaskWikiChooseTag<CR>
nnoremap <silent><buffer> <Space>tC  :TaskWikiCalendar<CR>
nnoremap <silent><buffer> <Space>td  :TaskWikiDone<CR>
nnoremap <silent><buffer> <Space>tD  :TaskWikiDelete<CR>
nnoremap <silent><buffer> <Space>te  :TaskWikiEdit<CR>
nnoremap <silent><buffer> <Space>thM :TaskWikiGhistoryMonthly<CR>
nnoremap <silent><buffer> <Space>thA :TaskWikiGhistoryAnnual<CR>
nnoremap <silent><buffer> <Space>thm :TaskWikiHistoryMonthly<CR>
nnoremap <silent><buffer> <Space>tha :TaskWikiHistoryAnnual<CR>
nnoremap <silent><buffer> <Space>ti  :TaskWikiInfo<CR>
nnoremap <silent><buffer> <Space>tA  :TaskWikiLink<CR>
nnoremap <silent><buffer> <Space>tm  :TaskWikiMod<CR>
nnoremap <silent><buffer> <Space>tvp  :TaskWikiProjects<CR>
nnoremap <silent><buffer> <Space>tvP  :TaskWikiProjectsSummary<CR>
nnoremap <silent><buffer> <Space>tvd :TaskWikiBurndownDaily<CR>
nnoremap <silent><buffer> <Space>tvw :TaskWikiBurndownWeekly<CR>
nnoremap <silent><buffer> <Space>tvm :TaskWikiBurndownMonthly<CR>
nnoremap <silent><buffer> <Space>tS  :TaskWikiStats<CR>
nnoremap <silent><buffer> <Space>tG  :TaskWikiTags<CR>
nnoremap <silent><buffer> <Space>t.  :TaskWikiRedo<CR>
nnoremap <silent><buffer> <Space>tb  :TaskWikiStart<CR>
nnoremap <silent><buffer> <Space>tq  :TaskWikiStop<CR>
nnoremap <silent><buffer> <Space>t<C-g> :TaskWikiGrid<CR>

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
    nnoremap <silent><buffer> <Space>ww :<C-u>call <SID>ControlChromiumPage('ctrl+r')<CR>
    nnoremap <silent><buffer> <Space>wj :<C-u>call <SID>ControlChromiumPage('Down', v:count1)<CR>
    nnoremap <silent><buffer> <Space>wk :<C-u>call <SID>ControlChromiumPage('Up', v:count1)<CR>
    nnoremap <silent><buffer> <Space>wd :<C-u>call <SID>ControlChromiumPage('Page_Down', v:count1)<CR>
    nnoremap <silent><buffer> <Space>wu :<C-u>call <SID>ControlChromiumPage('Page_Up', v:count1)<CR>
    nnoremap <silent><buffer> <Space>wgg :<C-u>call <SID>ControlChromiumPage('Home')<CR>
    nnoremap <Leader>cw :<C-u>call <SID>ToggleWikiAutoReload()<CR>
  endif
endif

function! s:ControlChromiumPage(key, ...) abort
  let current_window = system('xdotool getactivewindow')[:-2]
  let file_name = expand('%')
  let title =zettel#vimwiki#get_title(file_name)
  if title == ''
    " use the Zettel filename as title if it is empty
    let title = fnamemodify(file_name, ':t:r')
  endif
  let search_pattern = title . '.*Chromium'
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
    autocmd vimwiki_special BufWritePost <buffer> call s:controlChromiumPage('ctrl+r')
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
