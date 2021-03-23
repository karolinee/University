CC = gcc
ERRORS = -Wall -Wextra -Werror
CFLAGS = -lncurses -lmenu -I$(IDIR)

IDIR = ./include/
SRCDIR = ./src/

SOURCES = $(SRCDIR)*.c

all: install run 
debug: unsafe-install run  

install: $(SOURCES)
	$(CC) $(SOURCES) $(ERRORS) $(CFLAGS) -o game

unsafe-install:
	$(CC) $(SOURCES) $(CFLAGS) -g -o game

run:
	./game
clean:
	rm game