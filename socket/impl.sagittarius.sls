;; -*- mode:scheme; coding:utf-8; -*-
(library (socket impl)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
            (rename (bitwise-ior socket-merge-flags)
                    (bitwise-xor socket-parge-flags))
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    (rename (AF_UNSPEC *af-unspec*)
		    (AF_INET   *af-inet*)
		    (AF_INET6  *af-inet6*))
	    (rename (SOCK_STREAM *sock-stream*)
		    (SOCK_DGRAM  *sock-dgram*))
	    (rename (AI_PASSIVE     *ai-passive*)
		    (AI_CANONNAME   *ai-canoname*)
		    (AI_NUMERICHOST *ai-numerichost*)
		    (AI_V4MAPPED    *ai-v4mapped*)
		    (AI_ALL         *ai-all*)
		    (AI_ADDRCONFIG  *ai-addrconfig*))
            (rename (IPPROTO_IP  *ipproto-ip*)
		    (IPPROTO_TCP *ipproto-tcp*)
		    (IPPROTO_UDP *ipproto-udp*))
	    (rename (SHUT_RD   *shut-rd*)
		    (SHUT_WR   *shut-wr*)
		    (SHUT_RDWR *shut-rdwr*)))
    (import (rnrs) (rename (sagittarius socket)
			   (socket-send %socket-send)
			   (socket-recv %socket-recv)))

  (define IPPROTO_IP  0)
  (define IPPROTO_TCP 6)
  (define IPPROTO_UDP 17)

  (define (socket-send socket bv :optional (flags 0))
    (%socket-send socket bv flags))

  (define (socket-recv socket size :optional (flags 0))
    (%socket-recv socket size flags))
  )