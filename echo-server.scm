(import (rnrs) (socket))

(define echo-server-socket (make-server-socket "5000"))

;; addr is client socket
(define (server-run)
  (define (get-line-from-binary-port bin)
    (utf8->string
     (call-with-bytevector-output-port
      (lambda (out)
	(let loop ((b (get-u8 bin)))
	  (case b
	    ((#xA) #t) ;; newline
	    ((#xD) (loop (get-u8 bin))) ;; caridge return
	    (else (put-u8 out b) (loop (get-u8 bin)))))))))
  (call-with-socket (socket-accept echo-server-socket)
    (lambda (sock)
      (let ((in (socket-input-port sock))
	    (out (socket-output-port sock)))
	(let lp2 ((r (get-line-from-binary-port in)))
	  (unless (string=? r "test-end")
	    (put-bytevector out (string->utf8 (string-append r "\r\n")))
	    (lp2 (get-line-from-binary-port in))))))))
(server-run)