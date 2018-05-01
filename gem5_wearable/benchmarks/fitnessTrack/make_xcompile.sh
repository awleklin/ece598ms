gcc -Wall -c fitnessTrack.c
gcc -Wall -c gsl_histogram.c
gcc fitnessTrack.o gsl_histogram.o -I/home/wleklin2/ece598msfinal/ece598ms/benchmarks/fitnessTrack
