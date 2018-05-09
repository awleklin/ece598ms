arm-linux-gnueabihf-gcc -Wall -static -c fitnessTrack.c
arm-linux-gnueabihf-gcc -Wall -static  -c gsl_histogram.c
arm-linux-gnueabihf-gcc fitnessTrack.o gsl_histogram.o -I/home/chance/ece598ms/gem5_wearable/benchmarks/fitnessTrack -static -o fitnessTrack
