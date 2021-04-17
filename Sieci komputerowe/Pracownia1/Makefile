CC=g++
CFLAGS= -std=c++17 -Wall -Wextra

all: traceroute

traceroute: traceroute.o sender.o reciver.o packet.o
	$(CC) $(CFLAGS) traceroute.o sender.o reciver.o packet.o -o traceroute

traceroute.o: traceroute.cpp

send.o: sender.cpp sender.h

recive.o: reciver.cpp reciver.h

packet.o: packet.cpp packet.h

clean: 
	$(RM) *.o

distclean:
	$(RM) traceroute *.o
