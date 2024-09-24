target("plotting")
  set_kind("static")
  --set_languages("gfortran")
  add_files("plotting.f90")
	--likelly a better way to go about this
	add_ldflags("-lplfortrandemolib -I/usr/local/lib/fortran/modules/plplot/plplot -I/usr/include/plplot -I/usr/lib/x86_64-linux-gnu/fortran/modules/plplot -lplplotfortran -l gfortran -l m -shared-libgcc")
	add_includedirs("/usr/local/lib/fortran/modules/plplot")


target("test")
  set_kind("binary")
  add_deps("plotting")
  --set_languages("gfortran")
  add_files("test.f90")
	--likelly a better way to go about this
	--add_ldflags("-lplfortrandemolib -I/usr/local/lib/fortran/modules/plplot/plplot -I/usr/include/plplot -I/usr/lib/x86_64-linux-gnu/fortran/modules/plplot -lplplotfortran -l gfortran -l m -shared-libgcc")
	--add_includedirs("/usr/local/lib/fortran/modules/plplot")


