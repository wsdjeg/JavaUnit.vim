if exists("g:JavaUnit_key")
    let s:JavaUnit_key = g:JavaUnit_key
    exec 'nnoremap <silent> '.s:JavaUnit_key.' :call JaveUnitTestMethod("")<cr>'
endif

if exists("g:JavaUnit_ClassPath")
    let s:JavaUnit_ClassPath = g:JavaUnit_ClassPath
else
    call javaunit#JavaUnit_GetClassPath()
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
    let line = getline(search("package","nb",getline("0$")))
    let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    if a:args == ""
        let cwords = expand('<cword>')
        if filereadable('pom.xml')
            let cmd='java -cp '
                        \.s:JavaUnit_tempdir
                        \.':'
                        \.getcwd()
                        \.'/target/test-classes:'
                        \.g:JavaComplete_LibsPath
                        \.' com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.cwords
        else
            let cmd='java -cp '
                        \.s:JavaUnit_tempdir
                        \.':'
                        \.g:JavaComplete_LibsPath
                        \.' com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.cwords
        endif
        exec s:JavaUnit_Exec.JavaUnitEscapeCMD(cmd)
    else
        if filereadable('pom.xml')
            let cmd='java -cp '
                        \.s:JavaUnit_tempdir
                        \.':'
                        \.getcwd()
                        \.'/target/test-classes:'
                        \.g:JavaComplete_LibsPath
                        \.' com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.a:args
        else
            let cmd='java -cp '
                        \.s:JavaUnit_tempdir
                        \.':'
                        \.g:JavaComplete_LibsPath
                        \.' com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.a:args
        endif
        exec s:JavaUnit_Exec.JavaUnitEscapeCMD(cmd)
    endif
endfunction

function JavaUnitTestAllMethods()
    let line = getline(search("package","nb",getline("0$")))
    let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    let cmd='java -cp '.s:JavaUnit_tempdir.':'.g:JavaComplete_LibsPath.' com.wsdjeg.util.TestMethod '.currentClassName
    exec s:JavaUnit_Exec.JavaUnitEscapeCMD(cmd)
endfunction

function JavaUnitEscapeCMD(cmd)
    let s:cmd = substitute(a:cmd,' ','\\ ','g')
    return substitute(s:cmd,':','\\:','g')
endfunction

function JavaUnitMavenTest()
    let line = getline(search("package","nb",getline("0$")))
    let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    let cmd = 'mvn test -Dtest='.currentClassName.'|ag --nocolor "^[^[]"'
    exec s:JavaUnit_Exec.JavaUnitEscapeCMD(cmd)
endfunction

function JavaUnitMavenTestAll()
    exec s:JavaUnit_Exec.JavaUnitEscapeCMD('mvn test|ag --nocolor "^[^[]"')
endfunction

function JavaUnitNewClass(classNAME)
    let filePath = expand("%:h")
    let flag = 0
    let packageName = ''
    for a in split(filePath,"/")
        if flag
            if a == expand("%:h:t")
                let packageName .= a.';'
            else
                let packageName .= a.'.'
            endif
        endif
        if a == "java"
            let flag = 1
        endif
    endfor
    call append(0,"package ".packageName)
    call append(1,"import org.junit.Test;")
    call append(2,"import org.junit.Assert;")
    call append(3,"public class ".a:classNAME." {")
    call append(4,"@Test")
    call append(5,"public void testM() {")
    call append(6,"//TODO")
    call append(7,"}")
    call append(8,"}")
    call feedkeys("gg=G","n")
    call feedkeys("/testM\<cr>","n")
    call feedkeys("viw","n")
    "call feedkeys("/TODO\<cr>","n")
endfunction

command! -nargs=*
            \ JavaUnitTest
            \ call JaveUnitTestMethod(<q-args>)
command! -nargs=0
            \ JavaUnitTestAll
            \ call JavaUnitTestAllMethods()
command! -nargs=0
            \ JavaUnitMavenTest
            \ call JavaUnitMavenTest()
command! -nargs=0
            \ JavaUnitMavenTestAll
            \ call JavaUnitMavenTestAll()
command! -nargs=? -complete=file
            \ JavaUnitNewClass
            \ call JavaUnitNewClass(expand("%:t:r"))
