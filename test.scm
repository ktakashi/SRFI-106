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
	      (socket-send client-socket (string->utf8 "hello\r\n")))
  (test-equal "raw socket-recv"
	      (string->utf8 "hello\r\n")
	      (socket-recv client-socket (+ (string-length "hello") 2)))

  ;; make port
  (let ((port (socket-port client-socket)))
    (test-assert "port?" (port? port))
    (test-assert "binary-port?" (binary-port? port))
    (test-assert "input-port?" (input-port? port))
    (test-assert "output-port?" (output-port? port))

    (put-bytevector port (string->utf8 "put from port\r\n"))
    (test-equal "get-bytevector-n"
		(string->utf8 "put from port\r\n")
		(get-bytevector-n port
				  (string-length "put from port\r\n")))
    ;; textual
    (let ((text-port (transcoded-port port
				      (make-transcoder (utf-8-codec)
						       'crlf))))
      (put-string text-port "put from text port\r\n")
      (test-equal "get-line" "put from text port" (get-line text-port))
      ;; end test
      (put-string text-port "test-end\r\n"))))

(test-equal "shutdown-method" *shut-rd* (shutdown-method read))
(test-equal "shutdown-method" *shut-wr* (shutdown-method write))
(test-equal "shutdown-method" *shut-rdwr* (shutdown-method read write))
(test-error "shutdown-method(error duplicate)" values
	    (shutdown-method read write read))
(test-error "shutdown-method(error unknown)" values
	    (shutdown-method read&write))

(test-end)