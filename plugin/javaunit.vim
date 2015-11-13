if exists("g:JavaUnit_key")
    let s:JavaUnit_key = g:JavaUnit_key
    exec 'nnoremap <silent> '.s:JavaUnit_key.' :call TestMethod("")<cr>'
endif

if exists("g:JavaComplete_LibsPath")
    let s:JavaUnit_ClassPath = g:JavaComplete_LibsPath
else
    "call JavaUnit_GetClassPath()
endif

if exists("g:JavaUnit_tempdir")
    let s:JavaUnit_tempdir = g:JavaUnit_tempdir
else
    let s:JavaUnit_tempdir = '~/.vim/bundle/JavaUnit.vim/temp'
endif
let s:JavaUnit_Exec = "Unite -log -wrap output/shellcmd:"
let s:JavaUnit_TestMethod_Source = " ~/.vim/bundle/JavaUnit.vim/lib/com/wsdjeg/util/TestMethod.java"
lockvar! s:JavaUnit_Exec s:JavaUnit_TestMethod_Source
if findfile(s:JavaUnit_tempdir."/com/wsdjeg/util/TestMethod.class")==""
    silent exec "!javac -d ".s:JavaUnit_tempdir.s:JavaUnit_TestMethod_Source
endif
function JaveUnitTestMethod(args,...)
    if a:args == ""
        let s:wsdpath = expand("%:r")
        let s:cwords = expand('<cword>')
        let s:cmd='java -cp '.s:JavaUnit_tempdir.':'.s:JavaUnit_ClassPath.' com.wsdjeg.util.TestMethod '.s:wsdpath.' '.s:cwords
        exec s:JavaUnit_Exec.JavaUnitEscapeCMD(s:cmd)
    else
        let s:wsdpath = expand("%:r")
        let s:cmd='java -cp '.s:JavaUnit_tempdir.':'.s:JavaUnit_ClassPath.' com.wsdjeg.util.TestMethod '.s:wsdpath.' '.a:args
        exec s:JavaUnit_Exec.JavaUnitEscapeCMD(s:cmd)
    endif
endfunction

function JavaUnitTestAllMethods()
        let s:wsdpath = expand("%:r")
        exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.s:wsdpath
endfunction

function JavaUnitEscapeCMD(cmd)
    return substitute(a:cmd,' ','\\ ','g')
endfunction

command! -nargs=*
            \ JavaUnitTest
            \ call JaveUnitTestMethod(<q-args>)
command! -nargs=0
            \ JavaUnitTestAll
            \ call JavaUnitTestAllMethods()
