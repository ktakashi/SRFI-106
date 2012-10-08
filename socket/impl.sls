(library (socket impl)
    (export make-client-socket make-server-socket
	    socket? socket-port call-with-socket
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    AF_UNSPEC AF_INET AF_INET6
	    SOCK_STREAM SOCK_DGRAM
	    AI_PASSIVE AI_CANONNAME AI_NUMERICHOST
	    AI_V4MAPPED AI_ALL AI_ADDRCONFIG
            IPPROTO_IP IPPROTO_TCP IPPROTO_TCP
	    SHUT_RD SHUT_WR SHUT_RDWR)
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