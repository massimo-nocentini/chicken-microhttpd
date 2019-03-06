
all: microhttpd

microhttpd:
	csc -s microhttpd.scm -J -L /usr/local/lib/libmicrohttpd.dylib #-L /usr/lib/system/libsystem_network.dylib
	csc -s microhttpd.import.scm -J -L /usr/local/lib/libmicrohttpd.dylib
	csc -o hello-world.o hello-world.scm 
