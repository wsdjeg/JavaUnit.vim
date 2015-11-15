###JavaUnit.vim

requirement

1. jdk
2. [artur-shaik/javacomplete2](https://github.com/artur-shaik/vim-javacomplete2)
3. [scrooloose/syntastic](https://github.com/scrooloose/syntastic)
4. [Shougo/unite.vim](https://github.com/Shougo/unite.vim)

intall

- Neobulde

```vim
Neobundle 'wsdjeg/JavaUnit.vim'
```

- command

JavaUnitTest

test the method on the cursor

JavaUnitTest [args ...]

test specification method

example JavaUnitTest testMethod1 testMethod2 testMethod3 ...

also you can use JavaUnitTestAll,then will run all the testMethod in the current file

