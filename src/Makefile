
all: microhttpd

microhttpd:
	csc -s -u microhttpd.scm -J -L /usr/local/lib/libmicrohttpd.dylib
	csc -s -u microhttpd.import.scm -J -L /usr/local/lib/libmicrohttpd.dylib
	csc -u hello-world.scm -L /usr/local/lib/libmicrohttpd.dylib


