let s:save_cpo = &cpo
set cpo&vim
if exists('g:javaunit_util_loaded')
    finish
endif
let g:javaunit_util_loaded = 1


function! s:OSX()
    return has('macunix')
endfunction
function! s:LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
function! s:WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction

function! javaunit#util#Fsep() abort
    if s:WINDOWS()
        return '\'
    else
        return '/'
    endif
endfunction

function! javaunit#util#Psep() abort
    if s:WINDOWS()
        return ';'
    else
        return ':'
    endif
endfunction


function! javaunit#util#EscapeCMD(cmd)
    let s:cmd = substitute(a:cmd,' ',':','g')
    if s:WINDOWS()
        let s:cmd = substitute(s:cmd,';','\\;','g')
    endif
    let s:cmd = substitute(s:cmd,'\','\\\','g')
    let s:cmd = substitute(s:cmd, '\t', '\\t', 'g')
    return substitute(s:cmd,':','\\:','g')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
