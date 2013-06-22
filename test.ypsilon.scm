(import (rnrs) (socket))

(define-syntax test-begin
  (syntax-rules ()
    ((_ name) (values))
    ((_) (values))))
(define-syntax test-end (identifier-syntax test-begin))
(define-syntax test-assert
  (syntax-rules ()
    ((_ name expr) (assert expr))))
(define-syntax test-equal
  (syntax-rules ()
    ((_ name expected expr) (assert (equal? expected expr)))))


(test-begin "(run-socket-test)")
;; start echo server

(let ((client-socket (make-client-socket "localhost" "5000")))
  (test-assert "socket?"(socket? client-socket))
  (test-equal "raw socket-send"
	      (+ (string-length "hello") 2) ;; for \r\n
	      (socket-send client-socket (string->utf8 "hello\r\n") 0))
  (test-equal "raw socket-recv"
	      (string->utf8 "hello\r\n")
	      (socket-recv client-socket (+ (string-length "hello") 2) 0))

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
      (close-port text-port))
    ;; socket is not closed
    (socket-send client-socket (string->utf8 "test-end\r\n"))
    (socket-close client-socket)))
(test-end)