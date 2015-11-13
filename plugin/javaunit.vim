if exists("g:JavaUnit_key")
    let s:JavaUnit_key = g:JavaUnit_key
    exec 'nnoremap <silent> '.s:JavaUnit_key.' :call TestMethod("")<cr>'
endif

if exists("g:JavaUnit_ClassPath")
    let s:JavaUnit_ClassPath = g:JavaUnit_ClassPath
else
    "let s:JavaUnit_ClassPath = 
endif

function TestMethod(args,...)
    if a:args == ""
        let s:wsdpath = expand("%:r")
        let s:cwords = expand('<cword>')
        exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.s:wsdpath.'\ '.s:cwords
    else
        let s:wsdpath = expand("%:r")
        echom a:args
        let s:argss = substitute(a:args,' ','\\ ','g')
        exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.s:wsdpath.'\ '.s:argss
    endif
endfunction

command! -nargs=*
            \ JavaUnitTest
            \ call TestMethod(<q-args>)
function JavaUnit_GetClassPath()

endf

