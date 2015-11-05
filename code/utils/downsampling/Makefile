AT = @
CC = g++
INCLUDE = -I./ -I./external/include
LFLAGS = -Wall -lpthread -lrt

test : test.cpp
	$(CC) test.cpp $(INCLUDE) $(LFLAGS) -Wall -o test
	./test

test_opt: test.cpp
	$(CC) test.cpp $(INCLUDE) $(LFLAGS) -Wall -O3 -DNDEBUG -DBOOST_DISABLE_ASSERTS -o test_opt
	./test_opt

time: time.cpp
	$(CC) time.cpp $(INCLUDE) $(LFLAGS) -Wall -O3 -DNDEBUG -DBOOST_DISABLE_ASSERTS -o time
	./time

timedbg: time.cpp
	$(CC) time.cpp -g $(INCLUDE) $(LFLAGS) -Wall -o timedbg
	gdb ./timedbg

clean:
	$(AT)rm -rf test test_opt