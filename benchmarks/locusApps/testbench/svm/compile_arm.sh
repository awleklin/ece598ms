arm-linux-gnueabi-g++ -static -march=armv7-a  -c -o compiled.o *.c -I ../../lib -I ../../lib/m5
arm-linux-gnueabi-g++ -static -o svm compiled.o ../../lib/pthread.o ../../lib/m5/m5op_arm.S
