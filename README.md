[![Stories in Ready](https://badge.waffle.io/wsdjeg/JavaUnit.vim.png?label=ready&title=Ready)](https://waffle.io/wsdjeg/JavaUnit.vim)
###JavaUnit.vim

requirement

1. jdk

2. [artur-shaik/javacomplete2](https://github.com/artur-shaik/vim-javacomplete2)

3. [scrooloose/syntastic](https://github.com/scrooloose/syntastic)

   also you can use my fork which provide gradle support, [wsdjeg/syntastic](https://github.com/wsdjeg/syntastic)

4. [Shougo/unite.vim](https://github.com/Shougo/unite.vim)

install

- [neobundle.vim](https://github.com/Shougo/neobundle.vim)

```vim
NeoBundle 'wsdjeg/JavaUnit.vim'
```

- [Vundle.vim](https://github.com/VundleVim/Vundle.vim)

```vim
Plugin 'wsdjeg/JavaUnit.vim'
```

- command

JavaUnitTest

test the method on the cursor
![2015-11-16 23-40-05](https://cloud.githubusercontent.com/assets/13142418/11186276/e153459c-8cbb-11e5-9724-9589066176d0.png)

JavaUnitTest [args ...]

test specification method

example JavaUnitTest testMethod1 testMethod2 testMethod3 ...
![2015-11-16 23-40-25](https://cloud.githubusercontent.com/assets/13142418/11186274/e1520d9e-8cbb-11e5-90e1-17e6cfbc5a09.png)

also you can use `JavaUnitTestAll`,then will run all the testMethod in the current file
![2015-11-16 23-40-43](https://cloud.githubusercontent.com/assets/13142418/11186273/e132f580-8cbb-11e5-94d3-81dfda614abf.png)

support for maven project

JavaUnitMavenTest test current file

![JavaUnitMavenTest](https://cloud.githubusercontent.com/assets/13142418/11186066/ef8f70aa-8cba-11e5-9869-13f39a782ad7.png)

JavaUnitMavenTestAll test this project

![JavaUnitMavenTestAll](https://cloud.githubusercontent.com/assets/13142418/11186033/baf6f64c-8cba-11e5-989c-cd3dacb038b3.png)

