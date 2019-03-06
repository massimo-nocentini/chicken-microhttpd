
(import scheme (chicken base) (chicken io) (chicken foreign))
(import microhttpd)

    (define answer_to_connection 
     (lambda (cls connection url method version upload_data upload_data_size con_cls)
      (let* ((page "<html><body>Hello, browser!</body></html>")
             (response (MHD_create_response_from_buffer (string-length page) (& page) MHD_RESPMEM_PERSISTENT))
             (ret (MHD_queue_response connection MHD_HTTP_OK response)))
       (MHD_destroy_response response)
       ret)))

(define (main port)
 (let ((daemon (MHD_start_daemon
                MHD_USE_SELECT_INTERNALLY port NULL NULL
                answer_to_connection NULL)))
  (when (equal? NULL daemon) (print 'exiting) (exit 1))
  (print `(started daemon ,daemon))
  (read-line)
  (MHD_stop_daemon daemon)
  (print 'stopped)
  (exit 0)))

    (main 8080)
