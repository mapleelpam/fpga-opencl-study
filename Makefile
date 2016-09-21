
CFLAGS += -std=c99 -I./
CC=g++

AOCL_COMPILE_CONFIG=$(shell aocl compile-config)
AOCL_LINK_CONFIG=$(shell aocl link-config)

all: host_prog cpu_reduce reduce.aocx

host_prog : opencl_main.o AOCLUtils/opencl.o AOCLUtils/options.o
	${CC} -o $@ $^ $(AOCL_LINK_CONFIG)

opencl_main.o : opencl_main.cpp
	${CC} -o $@ -c $< $(AOCL_COMPILE_CONFIG) ${CFLAGS}

AOCLUtils/opencl.o : AOCLUtils/opencl.cpp
	${CC} -o $@ -c $< $(AOCL_COMPILE_CONFIG) ${CFLAGS}

AOCLUtils/options.o : AOCLUtils/options.cpp
	${CC} -o $@ -c $< $(AOCL_COMPILE_CONFIG) ${CFLAGS}

reduce.aocx : reduce.cl
	aoc -o $@ reduce.cl -march=emulator

cpu_reduce: cpu_main.c
	${CC} -o $@ $^

run_emulator: reduce.aocx host_prog
	./host_prog

clean:	
	rm -f *.o *.aoco host_prog cpu_reduce

.PHONY : run_emulator
