
# if CC isn't specified it will default to 'cc' in wich case prefer
# musl over gcc (the resulting image is much smaller)
ifeq ($(CC),cc)
CC := $(shell which klcc || which musl-gcc || which gcc)
endif

CFLAGS := -Werror -Wall -Os
LDFLAGS := -static -s

default: hardboot

install:  hardboot
	install -m 755 hardboot /sbin/hardboot
	install -m 755 hardboot.man /usr/share/man/man8/hardboot.8

uninstall:
	rm -f /sbin/hardboot /usr/share/man/man8/hardboot.8*

clean:
	rm -f *~ *.o hardboot

container:
	docker build -t hardboot . | cat
	docker images hardboot

.PHONY: default install uninstall clean container
