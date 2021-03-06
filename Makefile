TARGET = rsc-c
CC = clang

LIBS = -L/usr/local/lib -lev
INCLUDE = -I. -I/usr/local/include

CFLAGS = -std=c99 -Ofast -Wall $(INCLUDE)
LFLAGS = -Wall $(LIBS) $(INCLUDE)

SRCDIR = src
BINDIR = bin
SOURCES := $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/rsc/*.c) $(wildcard $(SRCDIR)/rsc/io/*.c)
OBJECTS := $(SOURCES:$(SRCDIR)/%.c=$(BINDIR)/%.o)

all: clean mkdir $(OBJECTS) link

mkdir:
	@mkdir -p $(BINDIR)/rsc
	@mkdir -p $(BINDIR)/rsc/io

bin/%.o: src/%.c
	@echo Compiling $<...
	@$(CC) -o $@ -c $(CFLAGS) $<

link:
	@echo Linking files..
	@$(CC) -o $(TARGET) $(LFLAGS) $(OBJECTS)
	@echo Successfully compiled $(TARGET)

clean:
	@rm -rf $(BINDIR)
	@rm -rf $(TARGET)
	@echo Deleted existing binaries
