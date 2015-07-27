title: Guile 简介
date: 2015-07-18 13:04:36
tags: [guile, scheme]
---


# 简介
Guile 是 Scheme 语言的一种实现，被 GNU 选作官方脚本语言。Scheme 的实现多得数不清，作为 GNU 官方脚本语言，Guile 有以下几个突出特点：

+ 良好的 FFI，能够非常方便地与 C 语言结合（用过 Racket 就会体会到这里带来的便利性）
+ 作为 GNU 项目，会持续得到 FSF 的支持。GNU make 已经加入对 Guile 的支持，还有其它许多 GNU 项目是用 Guile 写的或支持 Guile
+ 强调交互式和增量式编程，Guile 的交互式解释器非常好用，同时支持直接像 Shell 脚本一样使用
+ 除 Scheme 外还支持其它语言，如 ECMAScript, Elisp，实际上现在 Guile 已经发展得像 JVM 一样的虚拟机平台了


GNU 将 Guile 选作官方脚本语言，其中一个原因是 GNU 项目的代表作 GNU Emacs 非常强大，可扩展性非常好，给黑客带来了无限可能，自公布后就深受一代代黑客的喜爱，而这主要得益于 Emacs 使用了 Lisp 的一种方言 Elisp，但 Elisp 只能在 Emacs 中运行，因为 Elisp 设计之初就是为了写编辑器，故深度与编辑器结合，没法把它抠出来单独使用。GNU 希望这种强大的可扩展性能够用在所有 GNU 项目中，因而扶持了 Guile 项目，将其选为官方脚本语言。


因为 Guile 的定位是 GNU 脚本语言，所以不会去过分追求其语言本身的运行效率，即不会有编译器将 Guile 程序编译为二进制来提高运行效率，而重点在提高其通用性、扩展性以及与其它语言的互通性，故而有非常方便的 FFI 同时也支持多种语言。当然并不是说 Guile 运行效率很低，实际上 Guile 效率要比 Elisp 高很多，这也是为什么有人提出用 Guile 替换 Elisp 重写 Emacs，不过由于 Emacs 已经存在将近半个世纪了，这期间积累了大量的代码资源，想替换并不是那么容易的一件事，想了解具体情况可以看这里。


不过 GNU 项目一般都不那么高调，而且开发周期一般比较长，毕竟专职开发人员很少，Guile 项目最早开发于 1995 年，已经有 20 年了，但直到今天依然并不为多数人所熟知。不过由于有 GNU 的保障，现在已经有不少项目在使用 Guile 了。几个比较有名点的如：gdb, make, TeXmacs, WeeChat, Guix，[维基百科]()上面还列出了一些其它软件。


# 简单使用
作为 Scheme 的一种实现，可以在学习 SICP 时使用。因为主流 Linux 发行版都已经将 Guile 打包进官方库了，所以安装起来也特别方便。安装后直接在命令行中输入 guile 即可启动 Guile 交互式解释器了，默认提示符是 `scheme@(guile-user)>`，之后就可以将其当作 scheme 随意输入各种括号表达式玩了。不过默认情况下是没有 readline 和补全功能的，要开启的话只需在家目录下新建 *.guile* 文件，里面加上

```scheme
(use-modules (ice-9 readline))
(activate-readline)
```

一些简单的示例：

```scheme
(display "Hello, world!\n") ;经典的 Hello world 程序，分号表示注释
(+ 1 (* 2 3 (/ 6 2))) ;函数或操作符都在括号的第一个位置
(define pi 3.14159) ;定义变量(函数式中应该叫绑定，而且define定义的是全局绑定)
(define (square x) (* x x)) ;定义函数
(square pi)
(define (factorial n) ;定义阶乘函数
  (if (= n 1) 1
      (* (factorial (- n 1)) n))) ;递归在函数式编程中非常常见
(factorial 10)
```


# 脚本程序
Guile 可以像 Linux 下传统的脚本语言一样使用：编写脚本程序，赋予脚本文件可执行权限，加到 $PATH 路径中，输入程序名运行。

```scheme
#!/usr/bin/guile -s
!#

(display "Hello, world!\n")
```

将上面程序保存为 *hello.scm*，然后 `chmod +x hello.scm`，之后运行之 `./hello.scm`

脚本前两行必须是上面那两行，第一行必须 shebang 加 guile 绝对路径，告诉操作系统调用 guile 程序来解释，最后加 `-s`，告诉 guile 以脚本方式执行而不是启动一个交互式解释器，注意这一行不能使用 `#!/usr/bin/env guile -s`；第二行必须是 `!#`，操作系统不会读取解释这一行，这行只是告诉 Guile，神奇的说明已经结束，后面按正常的 guile 程序解释执行

如果脚本中含有非 ASCII 字符，需要在前5行中以注释形式说明使用什么编码，但是程序在终端中运行时仍然没法显示非 ASCII 字符，还必须设置程序运行的环境变量，如下是一个完整的可正常显示中文的脚本程序。其中 `;; coding: utf-8` 是说明文件编码方式，而 `(setlocale LC_ALL "")` 是设置程序运行环境

```scheme
#!/usr/bin/guile -s
!#

;; coding: utf-8
(setlocale LC_ALL "")
(display "世界，你好！\n")
```

运行的时候会自动编译为 Guile 字节码 _~/.cache/guile/ccache/VERSION/FILEPATH/FILENAME.go_，下次运行时如果脚本没有改动则直接加载字节码，这与 python 脚本运行机制差不多。
