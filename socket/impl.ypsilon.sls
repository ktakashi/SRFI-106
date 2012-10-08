(library (socket impl)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
            (rename (bitwise-ior socket-merge-flags)
                    (bitwise-xor socket-parge-flags))
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    AF_UNSPEC AF_INET AF_INET6
	    SOCK_STREAM SOCK_DGRAM
	    AI_PASSIVE AI_CANONNAME AI_NUMERICHOST
	    AI_V4MAPPED AI_ALL AI_ADDRCONFIG
            IPPROTO_IP IPPROTO_TCP IPPROTO_UDP
	    SHUT_RD SHUT_WR SHUT_RDWR)
    (import (rnrs) (rename (ypsilon socket)
			   (socket-send %socket-send)	
			   (socket-recv %socket-recv)))

  (define IPPROTO_IP 0)
  (define IPPROTO_TCP 6)
  (define IPPROTO_UDP 17)

  (define (socket-send socket bv . flags)
    (let ((flags (if (null? flags) 0 (car flags))))
      (%socket-send socket bv flags)))

  (define (socket-recv socket size . flags)
    (let ((flags (if (null? flags) 0 (car flags))))
      (%socket-recv socket size flags)))
)