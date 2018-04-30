TARGET = parser
LIBS = -L/usr/local/lib -I/usr/local/include -lfolly -lboost_regex -lboost_system -lglog -ldouble-conversion
CC = g++
CFLAGS = -std=c++11 -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
HEADERS = $(wildcard *.h)

%.o: %.cpp $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@ --sysroot=/usr $(LIBS)

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall --sysroot=/usr -o $@ $(LIBS)

clean:
	-rm -f *.o
	-rm -f $(TARGET)
