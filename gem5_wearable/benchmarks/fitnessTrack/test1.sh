gcc -Wall -c fitnessTrack.c
gcc fitnessTrack.o -L/home/linaro/ece598ms/gem5_wearable/benchmarks/fitnessTrack/ -lgsl -lgslcblas -lm -static
