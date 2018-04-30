gcc -Wall -c fitnessTrack.c
gcc -static -I/usr/local/include -lgsl -lgslcblas -lm fitnessTrack.o 
