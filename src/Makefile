
all: microhttpd

microhttpd:
	csc -s microhttpd.scm -J -L /usr/local/lib/libmicrohttpd.dylib  
	csc -s microhttpd.import.scm -J -L /usr/local/lib/libmicrohttpd.dylib
	csc hello-world.scm -L /usr/local/lib/libmicrohttpd.dylib


