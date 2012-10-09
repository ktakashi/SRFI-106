;; -*- mode:scheme; coding:utf-8; -*-
(library (socket impl)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
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
    (import (rnrs))

  (define-syntax define-unsupported
    (syntax-rules ()
      ((_ (name))
       (define (name . _)
	 (raise 
	  (condition (make-implementation-restriction-violation)
		     (make-who-condition 'name)
		     (make-message-condition
		      "This SRFI is not supported on this implementation")))))
      ((_ name)
       (define name #f))))

  (define-unsupported (make-client-socket))
  (define-unsupported (make-server-socket))
  (define-unsupported (socket?		 ))
  (define-unsupported (socket-port	 ))
  (define-unsupported (call-with-socket	 ))
  (define-unsupported (socket-accept	 ))
  (define-unsupported (socket-send	 ))
  (define-unsupported (socket-recv	 ))
  (define-unsupported (socket-shutdown	 ))
  (define-unsupported (socket-close      ))

  (define-unsupported AF_UNSPEC     )
  (define-unsupported AF_INET	    )
  (define-unsupported AF_INET6	    )
  (define-unsupported SOCK_STREAM   )
  (define-unsupported SOCK_DGRAM    )
  (define-unsupported AI_PASSIVE    )
  (define-unsupported AI_CANONNAME  )
  (define-unsupported AI_NUMERICHOST)
  (define-unsupported AI_V4MAPPED   )
  (define-unsupported AI_ALL	    )
  (define-unsupported AI_ADDRCONFIG )

  (define-unsupported IPPROTO_IP)
  (define-unsupported IPPROTO_TCP)
  (define-unsupported IPPROTO_UDP)

  (define-unsupported SHUT_RD)
  (define-unsupported SHUT_WR)
  (define-unsupported SHUT_RDWR)

)