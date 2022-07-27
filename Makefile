JAKT_HOME ?= /home/test/Documents/oss/jakt
JAKT_COMPILER = $(JAKT_HOME)/Build/jakt_stage3
JAKT_RUNTIME_DIR = $(JAKT_HOME)/runtime

ALL_JAKT_FILES = compiler.jakt logic.jakt main.jakt parser.jakt queue.jakt utils.jakt

all: build/main

build/main: $(ALL_JAKT_FILES)
	$(JAKT_COMPILER) -S -R $(JAKT_RUNTIME_DIR) main.jakt
	clang++ -std=c++20 -O3 -I $(JAKT_RUNTIME_DIR) build/main.cpp -o build/main -Wno-parentheses-equality -Wno-user-defined-literals

clean:
	@rm build/main
