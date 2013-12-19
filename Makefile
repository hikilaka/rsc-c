TARGET = rsc-c
CC = clang

LIBS = -L/usr/local/lib -llacewing
INCLUDE = -I. -I/usr/local/include

CFLAGS = -std=c99 -Ofast -Wall $(INCLUDE)
LFLAGS = -Wall $(LIBS) $(INCLUDE)

SRCDIR = src
BINDIR = bin
SOURCES := $(wildcard $(SRCDIR)/*.c) $(wildcard $(SRCDIR)/rsc/*.c)
OBJECTS := $(SOURCES:$(SRCDIR)/%.c=$(BINDIR)/%.o)

all: clean mkdir $(OBJECTS) link

mkdir:
	@mkdir -p $(BINDIR)/rsc

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