local success, wk = pcall(require, 'which-key')
if not success then
  return
end

-- nnoremap <Leader>wg :<C-u>VimwikiGenerateTagLinks<CR>
-- nnoremap <Leader>wtt :<C-u>execute 'VimwikiSearchTags '.expand('<cword>')<Bar>CocList -A --normal locationlist<CR>
-- nnoremap <Leader>wts :<C-u>VimwikiSearchTags<Space>
-- nnoremap <Leader>wb :<C-u>VimwikiBacklinks<CR>:lclose<CR>:CocList -A --normal locationlist<CR>
-- nnoremap <Leader>wB :<C-u>ZettelBackLinks<CR>
-- nnoremap <Leader>wa :<C-u>ZettelNew<Space>
-- nnoremap <Leader>wi :<C-u>ZettelInsertNote<CR>
