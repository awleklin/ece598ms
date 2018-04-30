arm-linux-gnueabi-gcc -Wall -c fitnessTrack.c
arm-linux-gnueabi-gcc -static -I/usr/local/include -L/usr/lib -lgsl -lgslcblas -lm fitnessTrack.o 
