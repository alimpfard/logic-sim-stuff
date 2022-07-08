JAKT_HOME ?= /home/test/Documents/oss/jakt
JAKT_COMPILER = $(JAKT_HOME)/target/debug/jakt
JAKT_RUNTIME_DIR = $(JAKT_HOME)/runtime

all: build/main

build/main:
	$(JAKT_COMPILER) -R $(JAKT_RUNTIME_DIR) main.jakt
