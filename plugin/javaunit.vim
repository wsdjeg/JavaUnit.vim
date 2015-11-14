if exists("g:JavaUnit_key")
    let s:JavaUnit_key = g:JavaUnit_key
    exec 'nnoremap <silent> '.s:JavaUnit_key.' :call JaveUnitTestMethod(" ")<cr>'
endif

if exists("g:JavaUnit_ClassPath")
    let s:JavaUnit_ClassPath = g:JavaUnit_ClassPath
else
    "call JavaUnit_GetClassPath()
endif

if exists("g:JavaUnit_tempdir")
    let s:JavaUnit_tempdir = g:JavaUnit_tempdir
else
    let s:JavaUnit_tempdir = '~/.vim/bundle/JavaUnit.vim/bin'
endif
let s:JavaUnit_Exec = "Unite -log -wrap output/shellcmd:"
let s:JavaUnit_TestMethod_Source = " ~/.vim/bundle/JavaUnit.vim/src/com/wsdjeg/util/TestMethod.java"
lockvar! s:JavaUnit_Exec s:JavaUnit_TestMethod_Source
if findfile(s:JavaUnit_tempdir."/com/wsdjeg/util/TestMethod.class")==""
    silent exec "!javac -d ".s:JavaUnit_tempdir.s:JavaUnit_TestMethod_Source
endif
function JaveUnitTestMethod(args,...)
    if a:args == ""
        let s:wsdpath = expand("%:r")
        let s:cwords = expand('<cword>')
        let s:cmd='java -cp '.s:JavaUnit_tempdir.':'.g:JavaComplete_LibsPath.' com.wsdjeg.util.TestMethod '.s:wsdpath.' '.s:cwords
        exec s:JavaUnit_Exec.JavaUnitEscapeCMD(s:cmd)
    else
        let s:wsdpath = expand("%:r")
        let s:cmd='java -cp '.s:JavaUnit_tempdir.':'.g:JavaComplete_LibsPath.' com.wsdjeg.util.TestMethod '.s:wsdpath.' '.a:args
        exec s:JavaUnit_Exec.JavaUnitEscapeCMD(s:cmd)
    endif
endfunction

function JavaUnitTestAllMethods()
        let s:wsdpath = expand("%:r")
        exec 'Unite -log -wrap output/shellcmd:java\ -cp\ target/classes\ com.wsdjeg.util.TestMethod\ '.s:wsdpath
endfunction

function JavaUnitEscapeCMD(cmd)
    let s:cmd = substitute(a:cmd,' ','\\ ','g')
    return substitute(s:cmd,':','\\:','g')
endfunction

command! -nargs=*
            \ JavaUnitTest
            \ call JaveUnitTestMethod(<q-args>)
command! -nargs=0
            \ JavaUnitTestAll
            \ call JavaUnitTestAllMethods()
