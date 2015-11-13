if exists("g:JavaUnit_key")
    let s:JavaUnit_key = g:JavaUnit_key
    exec 'nnoremap <silent> '.s:JavaUnit_key.' :call TestMethod()<cr>'
endif

function! TestMethod(...)
    if a:args == ""
        let s:wsdpath = expand("%:r")
        let s:cwords = expand('<cword>')
        exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.s:wsdpath.'\ '.s:cwords
    else
        let s:wsdpath = expand("%:r")
        exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.s:wsdpath.'\ '.a:args
    endif
endfunction

command! -nargs=*
            \ JavaUnitTest
            \ call TestMethod(<q-args>)
function JavaUnit_GetClassPath()

endf

