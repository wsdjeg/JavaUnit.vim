if exists("g:JavaUnit_autoloaded")&&g:JavaUnit_autoloaded==1
else
    let g:JavaUnit_autoloaded=1
endif
function javaunit#JavaUnit_GetClassPath()
endfunction

function! javaunit#JavaUnit_GetConnection(...)
    let s:username = split(a:000[0],' ')[0]
    let s:password = split(a:000[0],' ')[1]
    if filereadable('pom.xml')
        let cmd = 'java -cp '
                    \.g:JavaUnit_tempdir
                    \.':'
                    \.getcwd()
                    \.'/target/test-classes:'
                    \.g:JavaComplete_LibsPath
                    \.' com.wsdjeg.util.VimSqlUtils getconnection '
                    \.s:username
                    \.' '
                    \.s:password
    else
        let cmd = ' '
    endif
    "exec "Unite -log -wrap output/shellcmd:".JavaUnitEscapeCMD(cmd)
    if split(system(cmd),'\n')[0]=='true'
        let g:JavaUnit_SQL_connected = 'true'
        echo g:JavaUnit_SQL_connected
    else
        let g:JavaUnit_SQL_connected = 'false'
        echo g:JavaUnit_SQL_connected
    endif
endfunction
function! javaunit#JavaUnit_SQL_Use(...)
    if get(g:,'JavaUnit_SQL_connected','false')=='true'
        if a:1 == ''
            let s = input("please insert a databaseName?")
            echon "\r\r"
            echon ''
        else
            let s = a:000[0]
        endif
        if filereadable('pom.xml')
            let cmd = 'java -cp '
                        \.g:JavaUnit_tempdir
                        \.':'
                        \.getcwd()
                        \.'/target/test-classes:'
                        \.g:JavaComplete_LibsPath
                        \.' com.wsdjeg.util.VimSqlUtils usedatabase '
                        \.s
                        \.' '
                        \.s:username
                        \.' '
                        \.s:password
        else
            let cmd = ' '
        endif
        if split(system(cmd),'\n')[0]=='true'
            echo 'success change to '.s
            let g:JavaUnit_SQL_DatabaseName = s
        else
            let input1 = input('database do not exists,create it (Y/N)? ')
            echon "\r\r"
            echon ''
            echo input1
        endif
    else
        echo 'no connection!'
    endif
endfunction
