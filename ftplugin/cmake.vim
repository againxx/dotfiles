nnoremap <buffer> <Space>rp :AsyncTask project-run<CR>
nnoremap <buffer> <Space>rb :AsyncTask project-build<CR>
nnoremap <buffer> <Space>ri :AsyncTask project-init<CR>
nnoremap <buffer> <Space>rc :AsyncTask project-clean<CR>

function! s:catkinInit() abort
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
endfunction

call catkin#DetectPackage(function('s:catkinInit'))
