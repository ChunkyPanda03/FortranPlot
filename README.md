This is a plotting subroutine for fortran which calls PLplot, this uses the PLplot fortran bindings to do so.

A copy of the library must be installed to work and can either be installed with the binary [libplplotfortran0](https://packages.debian.org/testing/libs/libplplotfortran0) from debian or you can compile from [source](https://sourceforge.net/p/plplot/plplot/ci/master/tree/).

This is still an early work and I can not recommend using in production code.

I currently only support building for linux (Debian 12) using xmake, I have not tested building or runnning on any other operating system as I only use linux. However I am sure that this can be built for operating systems and would highly recommend that you pull request if you successfully make a target for other operating systems.

Follow [PLplot documentation](http://plplot.org/docbook-manual/plplot-html-5.15.0) to add more devices and drivers to make better plots I personally recommend the cairo driver... I might even make it the default if there are pitfalls with fine tunning.
