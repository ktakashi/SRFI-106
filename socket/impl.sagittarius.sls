;; -*- mode:scheme; coding:utf-8; -*-
(library (socket impl)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
            (rename (bitwise-ior socket-merge-flags)
                    (bitwise-xor socket-parge-flags))
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    (rename (AF_UNSPEC address-family/unspecified)
		    (AF_INET   address-family/ineternet)
		    (AF_INET6  address-family/ineternet6))
	    (rename (SOCK_STREAM socket-domain/stream)
		    (SOCK_DGRAM  socket-domain/datagram))
	    (rename (AI_PASSIVE     address-info/passive)
		    (AI_CANONNAME   address-info/canonical-name)
		    (AI_NUMERICHOST address-info/numeric-host)
		    (AI_V4MAPPED    address-info/ipv4-mapped)
		    (AI_ALL         address-info/all)
		    (AI_ADDRCONFIG  address-info/address-config))
            (rename (IPPROTO_IP  ip-protocol/ip)
		    (IPPROTO_TCP ip-protocol/tcp)
		    (IPPROTO_UDP ip-protocol/udp))
	    (rename (SHUT_RD   shutdown-method/read)
		    (SHUT_WR   shutdown-method/write)
		    (SHUT_RDWR shutdown-method/read&write)))
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