(import (rnrs) (socket) (srfi :64))

(test-begin "(run-socket-test)")
;; start echo server

(let ((client-socket (make-client-socket "localhost" "5000"
					 (address-family inet)
					 (socket-domain stream)
					 (address-info v4mapped addrconfig)
					 (ip-protocol ip))))
  (test-assert "socket?"(socket? client-socket))
  (test-equal "raw socket-send"
	      (+ (string-length "hello") 2) ;; for \r\n
	      (socket-send client-socket (string->utf8 "hello\r\n")
			   (message-type none)))
  (test-equal "raw socket-recv"
	      (string->utf8 "hello\r\n")
	      (socket-recv client-socket (+ (string-length "hello") 2)
			   (message-type none)))

  ;; make port
  (let ((in (socket-input-port client-socket))
	(out (socket-output-port client-socket)))
    (test-assert "port?" (port? in))
    (test-assert "port?" (port? out))
    (test-assert "binary-port?" (binary-port? in))
    (test-assert "binary-port?" (binary-port? out))
    (test-assert "input-port?" (input-port? in))
    (test-assert "output-port?" (output-port? out))

    (put-bytevector out (string->utf8 "put from port\r\n"))
    (test-equal "get-bytevector-n"
		(string->utf8 "put from port\r\n")
		(get-bytevector-n in (string-length "put from port\r\n")))
    ;; textual
    (let ((text-in (transcoded-port in (make-transcoder (utf-8-codec) 'crlf)))
	  (text-out (transcoded-port out (make-transcoder (utf-8-codec) 'crlf))))
      (put-string text-in "put from text port\r\n")
      (test-equal "get-line" "put from text port" (get-line text-out))
      (close-port text-in)
      (close-port text-out))
    ;; socket is not closed
    (socket-send client-socket (string->utf8 "test-end\r\n"))
    (socket-close client-socket)))

(test-equal "shutdown-method" *shut-rd* (shutdown-method read))
(test-equal "shutdown-method" *shut-wr* (shutdown-method write))
(test-equal "shutdown-method" *shut-rdwr* (shutdown-method read write))
(test-error "shutdown-method(error duplicate)" values
	    (shutdown-method read write read))
(test-error "shutdown-method(error unknown)" values
	    (shutdown-method read&write))

(test-end)