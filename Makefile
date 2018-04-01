
# if CC isn't specified it will default to 'cc' in wich case prefer
# musl over gcc (the resulting image is much smaller)
ifeq ($(CC),cc)
CC := $(shell which musl-gcc || which gcc)
endif

CFLAGS := -Werror -Wall -std=c99 -Os
LDFLAGS := -static

default: hardboot

hardboot: hardboot.o

hardboot.o: hardboot.c Makefile

stripped: hardboot
	strip hardboot

install:  stripped
	install -m 755 hardboot /sbin/hardboot
	install -m 755 hardboot.man /usr/share/man/man8/hardboot.8

uninstall:
	rm -f /sbin/hardboot /usr/share/man/man8/hardboot.8*

clean:
	rm -f *~ *.o hardboot

container:
	sudo docker build -t hardboot .
	sudo docker images | grep hardboot

.PHONY: default install uninstall clean container
