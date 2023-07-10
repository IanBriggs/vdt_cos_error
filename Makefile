

ifeq (, $(shell which brew))
else
export C_INCLUDE_PATH := /opt/homebrew/include:${C_INCLUDE_PATH}
export CPLUS_INCLUDE_PATH := /opt/homebrew/include:${CPLUS_INCLUDE_PATH}
export LIBRARY_PATH := /opt/homebrew/lib:${LIBRARY_PATH}
endif


.PHONY: all
all: bin/original_error_tester bin/reordered_error_tester

bin/original_error_tester: src/error_tester.cpp include/* | bin
	$(CXX) ${CFLAGS} -Iinclude $< -lmpfr -lgmp -lm -o $@

bin/reordered_error_tester: src/error_tester.cpp include/* | bin
	$(CXX) ${CFLAGS} -Ireordered_include $< -lmpfr -lgmp -lm -o $@

bin:
	mkdir -p bin

.PHONY: clean
clean:
	$(RM) -r bin
