
(import scheme (chicken base) (chicken io) (chicken foreign))
(import microhttpd)

 (foreign-declare "#include <microhttpd.h>")


(define-external
 (answer_to_connection
  (c-pointer cls)
  ((c-pointer (struct "MHD_Connection")) connection)
  ((const c-string) url)
  ((const c-string) method)
  ((const c-string) version)
  ((const c-string) upload_data)
  ((c-pointer size_t) upload_data_size)
  ((c-pointer (c-pointer void)) con_cls))
 int
 (begin
  (print* 'within)
  
  (let* ((page "<html><body>Hello, browser!</body></html>")
         (response (MHD_create_response_from_buffer 
                    (string-length page) page MHD_RESPMEM_PERSISTENT))
         (ret (MHD_queue_response connection MHD_HTTP_OK response)))
   (MHD_destroy_response response)
   ret)))


(define (main port)
 (let ((daemon (MHD_start_daemon
                MHD_USE_SELECT_INTERNALLY port NULL NULL
                (location answer_to_connection)
                NULL
                MHD_OPTION_END
                )))
  (when (equal? NULL daemon) (print 'exiting) (exit 1))
  (print `(started daemon ,daemon))
  (read-line)
  (MHD_stop_daemon daemon)
  (print 'stopped)
  (exit 0)))

    (main 8080)
