;; -*- mode:scheme; coding:utf-8; -*-
(library (socket)
    (export make-client-socket make-server-socket
	    socket?
	    (rename (socket-port socket-input-port)
                    (socket-port socket-output-port))
	    call-with-socket
	    socket-merge-flags socket-parge-flags
	    socket-accept socket-send socket-recv socket-shutdown socket-close
	    *af-unspec* *af-inet* *af-inet6*
	    *sock-stream* *sock-dgram*
	    *ai-canoname* *ai-numerichost*
	    *ai-v4mapped* *ai-all* *ai-addrconfig*
	    *ipproto-ip* *ipproto-tcp* *ipproto-udp*
	    *shut-rd* *shut-wr* *shut-rdwr*
	    address-family socket-domain address-info
	    ip-protocol message-type shutdown-method)
    (import (rnrs) (rename (socket impl) (socket-port %socket-port)))

  (define %address-family `((inet    ,*af-inet*)
			    (inet6   ,*af-inet6*)
			    (unspec  ,*af-unspec*)))
  (define %address-info `((canoname  	,*ai-canoname*)
			  (numerichost  ,*ai-numerichost*)
			  (v4mapped     ,*ai-v4mapped*)
			  (all          ,*ai-all*)
			  (addrconfig   ,*ai-addrconfig*)))

  (define %ip-protocol `((ip  ,*ipproto-ip*)
			 (tcp ,*ipproto-tcp*)
			 (udp ,*ipproto-udp*)))

  (define %socket-domain `((stream   ,*sock-stream*)
			   (datagram ,*sock-dgram*)))

  (define %message-types `((none 0)
			   (peek ,*msg-peek*)
			   (oob  ,*msg-oob*)
			   (wait-all ,*msg-waitall*)))

  (define (lookup who sets name)
    (cond ((assq name sets) => cadr)
	  (else (assertion-violation who "no name defined" name))))

  (define-syntax address-family
    (syntax-rules ()
      ((_ name)
       (lookup 'address-family %address-family 'name))))

  (define-syntax address-info
    (syntax-rules ()
      ((_ names ...)
       (apply socket-merge-flags 
	      (map (lambda (name) (lookup 'address-info %address-info name))
		   '(names ...))))))

  (define-syntax socket-domain
    (syntax-rules ()
      ((_ name)
       (lookup 'socket-domain %socket-domain 'name))))

  (define-syntax ip-protocol
    (syntax-rules ()
      ((_ name)
       (lookup 'ip-protocol %ip-protocol 'name))))

  (define-syntax message-type
    (syntax-rules ()
      ((_ names ...)
       (apply socket-merge-flags 
	      (map (lambda (name) (lookup 'message-type %message-types name))
		   '(names ...))))))

  (define (%proper-method methods)
    (define allowed-methods '(read write))
    (define (check-methods methods)
      (let loop ((methods methods) (seen '()))
	(cond ((null? methods))
	      ((memq (car methods) allowed-methods)
	       => (lambda (m)
		    (if (memq (car m) seen)
			(assertion-violation 'shutdown-method
					     "duplicate method" m)
			(loop (cdr methods) (cons (car m) seen)))))
	      (else (assertion-violation 'shutdown-method
					 "unknown method" (car methods))))))
    (check-methods methods)
    (if (null? (cdr methods))
	(case (car methods)
	  ((read) *shut-rd*)
	  ((write) *shut-wr*))
	*shut-rdwr*))

  (define-syntax shutdown-method
    (syntax-rules ()
      ((_ methods ...)
       (%proper-method '(methods ...)))))

  (define (socket-port socket . close?)
    (define (read! bv start count)
      (let ((r (socket-recv socket count)))
	(bytevector-copy! r 0 bv start (bytevector-length r))
	(bytevector-length r)))
    (define (write! bv start count)
      (let ((buf (make-bytevector count)))
	(bytevector-copy! bv start buf 0 count)
	(socket-send socket buf)))
    (if (or (null? close?) (not (car close?)))
	(make-custom-binary-input/output-port 
	 "socket-port" read! write! #f #f #f)
	(%socket-port socket)))
  )