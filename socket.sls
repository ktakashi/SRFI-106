(library (socket)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
	    socket-merge-flags socket-parge-flags
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    AF_UNSPEC AF_INET AF_INET6
	    SOCK_STREAM SOCK_DGRAM
	    AI_PASSIVE AI_CANONNAME AI_NUMERICHOST
	    AI_V4MAPPED AI_ALL AI_ADDRCONFIG
	    IPPROTO_IP IPPROTO_TCP IPPROTO_UDP
	    SHUT_RD SHUT_WR SHUT_RDWR)
    (import (socket impl)))