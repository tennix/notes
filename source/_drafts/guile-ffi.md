title: Guile 中的 FFI 之与 C 相互调用
date: 2015-07-24 23:48:26
tags: [guile, c]
---

在C程序中启动一个Guile Shell
``c
#include <libguile.h>

static void inner_main(void *closure, int argc, char **argv) {
    scm_shell(argc, argv);
}

int main(int argc, char **argv) {
    scm_boot_guile(argc, argv, inner_main, 0);
    return 0;
}
``


用C编写Guile扩展
``c
#include <math.h>
#include <libguile.h>

SCM j0_wrapper(SCM x)
{
  return scm_from_double(j0 (scm_to_double(x)));
}

void init_bessel()
{
  scm_c_define_gsubr("j0", 1, 0, 0, j0_wrapper);
}
``

``gcc `pkg-config --cflags guile-2.0` -shared -o libguile-bessel.so -fPIC bessel.c``



