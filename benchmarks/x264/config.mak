SRCPATH=.
prefix=/usr
exec_prefix=${prefix}
bindir=${exec_prefix}/bin
libdir=${exec_prefix}/lib
includedir=${prefix}/include
SYS_ARCH=X86
SYS=LINUX
CC=gcc
CFLAGS=-Wno-maybe-uninitialized -Wshadow -O3 -ffast-math -m32  -Wall -I. -I$(SRCPATH) -march=i686 -mfpmath=sse -msse -msse2 -std=gnu99 -D_GNU_SOURCE -mpreferred-stack-boundary=6 -fomit-frame-pointer -fno-tree-vectorize
COMPILER=GNU
COMPILER_STYLE=GNU
DEPMM=-MM -g0
DEPMT=-MT
LD=gcc -o 
LDFLAGS=-m32  -lm -lpthread -ldl
LIBX264=libx264.a
AR=gcc-ar rc 
RANLIB=gcc-ranlib
STRIP=strip
INSTALL=install
AS=nasm
ASFLAGS= -I. -I$(SRCPATH) -DARCH_X86_64=0 -I$(SRCPATH)/common/x86/ -f elf32 -DSTACK_ALIGNMENT=64
RC=
RCFLAGS=
EXE=
HAVE_GETOPT_LONG=1
DEVNULL=/dev/null
PROF_GEN_CC=-fprofile-generate
PROF_GEN_LD=-fprofile-generate
PROF_USE_CC=-fprofile-use
PROF_USE_LD=-fprofile-use
HAVE_OPENCL=yes
CC_O=-o $@
SOSUFFIX=so
SONAME=libx264.so.155
SOFLAGS=-shared -Wl,-soname,$(SONAME) 
default: lib-shared
install: install-lib-shared
LDFLAGSCLI = 
CLI_LIBX264 = $(LIBX264)
