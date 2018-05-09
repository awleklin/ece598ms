SRCPATH=.
prefix=/usr/local
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
libdir=${exec_prefix}/lib
includedir=${prefix}/include
SYS_ARCH=ARM
SYS=LINUX
CC=/usr/bin/arm-linux-gnueabihf-gcc
CFLAGS=-Wno-maybe-uninitialized -Wshadow -O3 -ffast-math  -Wall -I. -I$(SRCPATH) -std=gnu99 -D_GNU_SOURCE -fomit-frame-pointer -fno-tree-vectorize -static -march=armv7-a
COMPILER=GNU
COMPILER_STYLE=GNU
DEPMM=-MM -g0
DEPMT=-MT
LD=/usr/bin/arm-linux-gnueabihf-gcc -o 
LDFLAGS= -lm -lpthread -static -march=armv7-a
LIBX264=libx264.a
AR=/usr/bin/arm-linux-gnueabihf-gcc-ar rc 
RANLIB=/usr/bin/arm-linux-gnueabihf-gcc-ranlib
STRIP=/usr/bin/arm-linux-gnueabihf-strip
INSTALL=install
AS=
ASFLAGS= -I. -I$(SRCPATH) -DSTACK_ALIGNMENT=4
RC=
RCFLAGS=
EXE=
HAVE_GETOPT_LONG=1
DEVNULL=/dev/null
PROF_GEN_CC=-fprofile-generate
PROF_GEN_LD=-fprofile-generate
PROF_USE_CC=-fprofile-use
PROF_USE_LD=-fprofile-use
HAVE_OPENCL=no
CC_O=-o $@
default: cli
install: install-cli
default: lib-static
install: install-lib-static
LDFLAGSCLI = -ldl 
CLI_LIBX264 = $(LIBX264)
