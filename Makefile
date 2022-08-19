JAKT_HOME ?= /home/test/Documents/oss/jakt
JAKT_COMPILER ?= $(JAKT_HOME)/Build/jakt
JAKT_RUNTIME ?= $(JAKT_HOME)/runtime

ALL_JAKT_FILES = compiler.jakt logic.jakt main.jakt parser.jakt queue.jakt utils.jakt fault_analysis.jakt

all: build/main

OPT ?= -O3
DEBUG ?= -ggdb3

build/main: $(ALL_JAKT_FILES)
	@mkdir -p build
	$(JAKT_COMPILER) -S -R $(JAKT_RUNTIME) main.jakt
	clang++ -std=c++20 $(OPT) $(DEBUG) -I $(JAKT_RUNTIME) build/main.cpp -o build/main -Wno-parentheses-equality -Wno-user-defined-literals

clean:
	@rm build/main
