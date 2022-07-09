JAKT_HOME ?= /home/test/Documents/oss/jakt
JAKT_COMPILER = $(JAKT_HOME)/target/debug/jakt
JAKT_RUNTIME_DIR = $(JAKT_HOME)/runtime

ALL_JAKT_FILES = compiler.jakt logic.jakt main.jakt parser.jakt queue.jakt utils.jakt

all: build/main

build/main: $(ALL_JAKT_FILES)
	$(JAKT_COMPILER) -R $(JAKT_RUNTIME_DIR) main.jakt

clean:
	@rm build/main
