let s:save_cpo = &cpo
set cpo&vim

if exists('g:JavaUnit_loaded')
    finish
endif
let g:JavaUnit_loaded = 1

let s:Fsep = javaunit#util#Fsep()

let s:Psep = javaunit#util#Psep()

let g:JavaUnit_Home = fnamemodify(expand('<sfile>'), ':p:h:h:gs?\\?'. s:Fsep. '?')

if exists("g:JavaUnit_custom_tempdir")
    let g:JavaUnit_tempdir = g:JavaUnit_custom_tempdir
else
    let g:JavaUnit_tempdir = g:JavaUnit_Home .s:Fsep .'bin'
endif

let s:JavaUnit_TestMethod_Source = g:JavaUnit_Home .s:Fsep .join(['src','com','wsdjeg','util','TestMethod.java'],s:Fsep)

lockvar! s:JavaUnit_TestMethod_Source g:JavaUnit_tempdir

if findfile(g:JavaUnit_tempdir.join(['','com','wsdjeg','util','TestMethod.class'],s:Fsep))==""
    silent exec '!javac -encoding utf8 -d "'.g:JavaUnit_tempdir.'" "'.s:JavaUnit_TestMethod_Source .'"'
endif

function JaveUnitTestMethod(args,...)
    let line = getline(search("package","nb",getline("0$")))
    if line != ''
        let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    else
        let currentClassName = expand("%:t:r")
    endif
    if a:args == ""
        let cwords = split(airline#extensions#tagbar#currenttag(),'(')[0]
        if filereadable('pom.xml')
            let cmd='java -cp "'
                        \.g:JavaUnit_tempdir
                        \.s:Psep
                        \.getcwd()
                        \.join(['','target','test-classes'],s:Fsep)
                        \.s:Psep
                        \.get(g:,'JavaComplete_LibsPath','.')
                        \.'" com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.cwords
        else
            let cmd='java -cp "'
                        \.g:JavaUnit_tempdir
                        \.s:Psep
                        \.get(g:,'JavaComplete_LibsPath','.')
                        \.'" com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.cwords
        endif
        call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1})
    else
        if filereadable('pom.xml')
            let cmd='java -cp "'
                        \.g:JavaUnit_tempdir
                        \.s:Psep
                        \.getcwd()
                        \.join(['','target','test-classes'],s:Fsep)
                        \.s:Psep
                        \.get(g:,'JavaComplete_LibsPath','.')
                        \.'" com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.a:args
        else
            let cmd='java -cp "'
                        \.g:JavaUnit_tempdir
                        \.s:Psep
                        \.get(g:,'JavaComplete_LibsPath','.')
                        \.'" com.wsdjeg.util.TestMethod '
                        \.currentClassName
                        \.' '
                        \.a:args
        endif
        call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1})
    endif
endfunction

function JavaUnitTestAllMethods()
    let line = getline(search("package","nb",getline("0$")))
    let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    let cmd='java -cp "'.g:JavaUnit_tempdir.s:Psep.g:JavaComplete_LibsPath.'" com.wsdjeg.util.TestMethod '.currentClassName
    call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1})
endfunction

function JavaUnitEscapeCMD(cmd)
    let s:cmd = substitute(a:cmd,' ','\\ ','g')
    let s:cmd = substitute(s:cmd,'\','\\\','g')
    let s:cmd = substitute(s:cmd,';','\\;','g')
    let s:cmd = substitute(s:cmd, '\t', '\\t', 'g')
    return substitute(s:cmd,':','\\:','g')
endfunction

function JavaUnitMavenTest()
    let line = getline(search("package","nb",getline("0$")))
    let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    let cmd = 'mvn test -Dtest='.currentClassName.'|ag --nocolor "^[^[]"'
    call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1})
endfunction

function JavaUnitMavenTestAll()
    let cmd = 'mvn test|ag --nocolor "^[^[]"'
    call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1})
endfunction

function JavaUnitNewClass(classNAME)
    let filePath = expand("%:h")
    let flag = 0
    let packageName = ''
    for a in split(filePath,s:Fsep)
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
            \ JavaUnitExec
            \ call javaunit#TestMain()
command! -nargs=0
            \ JavaUnitTestAll
            \ call JavaUnitTestAllMethods()
command! -nargs=0
            \ JavaUnitTestMaven
            \ call JavaUnitMavenTest()
command! -nargs=0
            \ JavaUnitTestMavenAll
            \ call JavaUnitMavenTestAll()
command! -nargs=? -complete=file
            \ JavaUnitTestNewClass
            \ call JavaUnitNewClass(expand("%:t:r"))

let &cpo = s:save_cpo
unlet s:save_cpo
