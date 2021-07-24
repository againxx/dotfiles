function! s:CatkinInit() abort
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
endfunction

call catkin#DetectPackage(function('s:CatkinInit'))
