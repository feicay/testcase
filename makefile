CC = g++ -g  -Wall -fPIC
AR = ar

PROJ_LIB = libTest.a
PROJ_OBJ = Test.pb.o
ARFLAGS=rcs
SRC=server.cpp client.cpp
OBJ=server.o client.o
BIN=server client

LDFLAGS=-lpthread -lprotobuf
COMMON=-I/usr/local/include -std=c++11
CFLAGS=-L/usr/local/lib

all:$(PROJ_LIB) $(BIN)

prepare:
	protoc --cpp_out=./ Test.proto
	$(CC) $(COMMON) -c Test.pb.cc -o $(PROJ_OBJ)

$(PROJ_LIB):$(PROJ_OBJ)
	$(AR) $(ARFLAGS) $@ $^

%.o:%.cpp
	$(CC) $(COMMON) -c $^ -o $@

$(BIN):$(OBJ)
	$(CC) $(CFLAGS) server.o $(PROJ_LIB) -o server $(LDFLAGS)
	$(CC) $(CFLAGS) client.o $(PROJ_LIB) -o client $(LDFLAGS)

clean:
	rm -f $(OBJ)
	rm -f *.a
	rm $(BIN)
