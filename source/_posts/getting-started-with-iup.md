title: 开始使用 IUP 图形库
date: 2015-07-18 12:56:34
tags: [gui, c]
---

# 简介
常见的跨平台 GUI toolkit 有 Gtk、Qt、wxWidgets等，其中只有 Gtk 是用 C 写的，这些库的共同特点是大而全，运行时依赖较多，而且学习使用起来也比较困难一些，尤其是 Qt，几乎把 C++ 标准库里的东西都重新实现了一遍。如果客户对应平台恰好已经安装了这些库还好说，没有安装的话就会是一件很痛苦的事情，尤其是 Windows 平台下，环境整起来非常麻烦。

其实对于一些简单应用完全没必要弄这些大而全的图形库，一个简单小巧够用的库就行了，而 IUP 正是这样一个轻量简洁跨平台 GUI toolkit，它是用纯 C 编写的，Linux 下 IUP 的动态链接库只有 800k，静态链接库也只有 1.5M，相比 Qt 和 Gtk 都要小很多，算是一个非常轻量级的图形库了，上手也比较快，而且渲染时使用的是系统原生界面，所以非常适合一些跨平台的小项目。


# 安装
从官网下载 tar 压缩包或 zip 压缩包，IUP 项目开发是放在 sourceforge 上的，前段时间 Sourceforge 上一些开源项目中被发现植入了广告，受到业界批评，最近在网站在整改，只能下载文件，不能访问项目页面了。下载后解压，进入目录输入 `make` 编译（我在 ArchLinux 下编译中间报了一些错误，但仍然编译出了库文件，使用简单的例子也没有出现什么问题）。编译完成后，会在当前目录生成 *lib/linux40_64/libiup.so* 和 *lib/linux40_64/libiup.a*，如果需要安装的话可以再 `make install`，这里我没有安装，直接测试了几个 demo(从 chicken-scheme 的 wiki 上面抄的)

demo1
```c
#include "iup.h"
#include <stdlib.h>

int main(int argc, char* argv[]) {
    IupOpen(&argc, &argv);
    IupShow(IupDialog(IupLabel("Hello,world!")));
    IupMainLoop();
    IupClose();
    return 0;
}
```

demo2
```
#include "iup.h"
#include <stdlib.h>

int exit_cb() {
  return IUP_CLOSE;
}

int main(int argc, char* argv[]) {
  /* declare widgets */
  Ihandle *btn, *lbl, *vb, *dlg;

  /* initialize iup */
  IupOpen(&argc, &argv);

  /* create widgets and set their attributes */
  btn = IupButton("&Ok", "");
  IupSetCallback(btn, "ACTION", (Icallback)exit_cb);
  IupSetAttribute(btn, "EXPAND", "Yes");
  IupSetAttribute(btn, "TIP", "Exit button");

  lbl = IupLabel("Hello,world!");

  vb = IupVbox(lbl, btn, NULL);
  IupSetAttribute(vb, "GAP", "10");
  IupSetAttribute(vb, "MARGIN", "10x10");
  IupSetAttribute(vb, "ALIGNMENT", "ACENTER");

  dlg = IupDialog(vb);
  IupSetAttribute(dlg, "TITLE", "Hello");

  /* map widgets and show dialog */
  IupShow(dlg);

  /* wait for user interaction */
  IupMainLoop();

  /* clean up */
  IupDestroy(dlg);
  IupClose();
  return EXIT_SUCCESS;
}
```

两个例子都很简单，即使没有 GUI 编程经验的人看一眼也能够明白，这就是 IUP 的简洁性。编译过程也很直接：
+ 因为都只额外引入了 *iup.h* 头文件，所以只需要在编译时指定头文件在哪即可 `gcc -c hello.c -I./include`，这会生成 *hello.o* 文件
+ 链接时只需指定库文件的位置即可 `gcc hello.o -o hello -L./lib/lib40_64 -liup`
+ 如果之前是 `make install` 将 IUP 安装到系统路径下的话，则这里可以直接 `./hello` 运行程序；否则的话需要将 IUP 库文件路径加入 `$LD_LIBRARY_PATH` 中：`export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/Projects/iup/lib/linux40_64` 然后再 `./hello`

整个过程都非常简单直接。IUP 的核心概念也只有4个，完全可以在半天时间内通读文档并消化，所以下次有项目需要使用 GUI 时不妨考虑一下 IUP 这个轻量级图形库。
