if exists("g:JavaUnit_autoloaded")&&g:JavaUnit_autoloaded==1
else
    let g:JavaUnit_autoloaded=1
endif

function javaunit#JavaUnit_GetClassPath()
endfunction

function! javaunit#JavaUnit_GetConnection(...)
    let s:username = split(a:000[0],' ')[0]
    let s:password = split(a:000[0],' ')[1]
    if get(g:,'JavaUnit_SQL_Driver','')!=''
        let cmd = 'java -cp '
                    \.g:JavaUnit_SQL_Driver
                    \.':'
                    \.g:JavaUnit_tempdir
                    \.' com.wsdjeg.util.VimSqlUtils getconnection '
                    \.s:username
                    \.' '
                    \.s:password
    else
        let cmd = ''
    endif
    if cmd != ''
        if split(system(cmd),'\n')[0]=='true'
            let g:JavaUnit_SQL_connected = 'true'
            echo g:JavaUnit_SQL_connected
        else
            let g:JavaUnit_SQL_connected = 'false'
            echo g:JavaUnit_SQL_connected
        endif
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
        if get(g:,'JavaUnit_SQL_Driver','')!=''
            let cmd = 'java -cp '
                        \.g:JavaUnit_SQL_Driver
                        \.':'
                        \.g:JavaUnit_tempdir
                        \.' com.wsdjeg.util.VimSqlUtils usedatabase '
                        \.s
                        \.' '
                        \.s:username
                        \.' '
                        \.s:password
        else
            let cmd = ''
        endif
        if cmd != ''
            if split(system(cmd),'\n')[0]=='true'
                echo 'success change to '.s
                let g:JavaUnit_SQL_DatabaseName = s
            else
                let input1 = input('database do not exists,create it (Y/N)? ')
                echon "\r\r"
                echon ''
                if input1 == 'Y'||input1 =='y'
                    let cmd = 'java -cp '
                                \.g:JavaUnit_SQL_Driver
                                \.':'
                                \.g:JavaUnit_tempdir
                                \.' com.wsdjeg.util.VimSqlUtils createdatabase '
                                \.s
                                \.' '
                                \.s:username
                                \.' '
                                \.s:password
                    if split(system(cmd),'\n')[0]=='true'
                        echo 'create success,change to '.s
                        let g:JavaUnit_SQL_DatabaseName = s
                    else
                        echo 'create failed!'
                    endif
                else
                    echo 'byby!'
                endif
            endif
        endif
    else
        echo 'no connection!'
    endif
endfunction

function! s:JavaUnit_SQL_drop_database(...)
    let input1 = input('try to delete '.a:1.' (Y/N)? ')
    echon "\r\r"
    echon ''
    if input1 == 'Y'||input1 =='y'
        let cmd = 'java -cp '
                    \.g:JavaUnit_SQL_Driver
                    \.':'
                    \.g:JavaUnit_tempdir
                    \.' com.wsdjeg.util.VimSqlUtils dropdatabase '
                    \.a:1
                    \.' '
                    \.s:username
                    \.' '
                    \.s:password
        if split(system(cmd),'\n')[0]=='true'
            echo 'delete success ! '
            let g:JavaUnit_SQL_DatabaseName = ''
        else
            echo 'no such database!'
        endif
    else
        echo 'byby!'
    endif
endf
function! s:JavaUnit_SQL_drop_table(...)
    if get(g:,'JavaUnit_SQL_DatabaseName','')!=''
        let input1 = input('try to delete '.a:1.' (Y/N)? ')
        echon "\r\r"
        echon ''
        if input1 == 'Y'||input1 =='y'
            let cmd = 'java -cp '
                        \.g:JavaUnit_SQL_Driver
                        \.':'
                        \.g:JavaUnit_tempdir
                        \.' com.wsdjeg.util.VimSqlUtils droptable '
                        \.g:JavaUnit_SQL_DatabaseName
                        \.' '
                        \.a:1
                        \.' '
                        \.s:username
                        \.' '
                        \.s:password
            if split(system(cmd),'\n')[0]=='true'
                echo 'delete success ! '
            else
                echo 'no such table!'
            endif
        else
            echo 'byby!'
        endif
    else
        echo 'please select a database!'
    endif
endf
function! javaunit#JavaUnit_SQL_drop(...)
    if get(g:,'JavaUnit_SQL_connected','false')=='true'
        if split(a:000[0],' ')[0]=='database'
            call s:JavaUnit_SQL_drop_database(split(a:000[0],' ')[1])
        elseif split(a:000[0],' ')[0]=='table'
            call s:JavaUnit_SQL_drop_table(split(a:000[0],' ')[1])
        else
            echo 'wrong input!'
        endif
    else
        echo 'no connection!'
    endif
endfunction
