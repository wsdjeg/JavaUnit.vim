let s:save_cpo = &cpo
set cpo&vim
if exists('g:JavaUnit_autoload')
    finish
endif
let g:JavaUnit_autoload = 1
let s:Fsep = javaunit#util#Fsep()

let s:Psep = javaunit#util#Psep()
function! javaunit#Get_method_name() abort
    let name = 'sss'
    return name
endfunction

function! javaunit#TestMain() abort
    let line = getline(search("package","nb",getline("0$")))
    if line != ''
        let currentClassName = split(split(line," ")[1],";")[0].".".expand("%:t:r")
    else
        let currentClassName = expand("%:t:r")
    endif
        if filereadable('pom.xml')
            let cmd='java -cp "'
                        \.g:JavaUnit_tempdir
                        \.s:Psep
                        \.getcwd()
                        \.join(['','target','test-classes'],s:Fsep)
                        \.s:Psep
                        \.get(g:,'JavaComplete_LibsPath','.')
                        \.'" '
                        \.currentClassName
        else
            let cmd='java -cp "'
                        \.g:JavaUnit_tempdir
                        \.s:Psep
                        \.get(g:,'JavaComplete_LibsPath','.')
                        \.'" '
                        \.currentClassName
        endif
        call unite#start([['output/shellcmd', cmd]], {'log': 1, 'wrap': 1})
endfunction
let &cpo = s:save_cpo
unlet s:save_cpo
