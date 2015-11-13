if exists(g:JavaUnit_key)
    let s:JavaUnit_key = g:JavaUnit_key
    exec 'nnoremap <silent> '.s:JavaUnit_key.' :call TestMethod()<cr>'
endif

function! TestMethod()
    let g:wsdpath = expand("%:r")
    let g:cwords = expand('<cword>')
    exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.g:wsdpath.'\ '.g:cwords
endfunction

