Usage instructions:

1. You must configure the x264 Makefile by running the following:

    export CCPREFIX="/usr/bin/arm-linux-gnueabihf-"

    ./configure --host=arm-linux --extra-cflags='-march=armv7-a' \
        --extra-ldflags='march=armv7-a' --cross-prefix=${CCPREFIX} \
        --enable-static --disable-asm

2. You can now type "make example" to build the executable

    ./example <number of seconds>

If no time is specified, the default is 5s.

If changes are made to example.c, you must recompile using: "make example"
