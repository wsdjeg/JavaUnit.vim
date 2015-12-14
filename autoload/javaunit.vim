let s:save_cpo = &cpo
set cpo&vim
if exists('g:JavaUnit_autoload')
    finish
endif
let g:JavaUnit_autoload = 1
function! javaunit#Get_method_name() abort
    let name = 'sss'
    return name
endfunction
let &cpo = s:save_cpo
unlet s:save_cpo
