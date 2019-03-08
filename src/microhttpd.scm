
(module microhttpd *

 (import scheme (chicken format) (chicken base) (chicken foreign))

 (define (& obj)
  (location obj))

 (define NULL (foreign-value "NULL" c-pointer))

 (foreign-declare "#include <microhttpd.h>")

 (define-foreign-type socklen_t unsigned-int)

 (define-foreign-type MHD_AcceptPolicyCallback
  (function int (c-pointer (const (c-pointer (struct "sockaddr"))) socklen_t)))

 (define-foreign-type MHD_AccessHandlerCallback
  (function int
   (c-pointer
    (c-pointer (struct "MHD_Connection"))
    (const c-string)
    (const c-string)
    (const c-string)
    (const c-string)
    (c-pointer size_t)
    pointer-vector)))

 (define MHD_create_response_from_buffer
  (foreign-lambda
   (c-pointer (struct "MHD_Response"))
   "MHD_create_response_from_buffer"
   size_t c-pointer (enum "MHD_ResponseMemoryMode")))

 (define MHD_queue_response
  (foreign-lambda
   int
   "MHD_queue_response"
   (c-pointer (struct "MHD_Connection"))
   unsigned-int
   (c-pointer (struct "MHD_Response"))))

 (define MHD_destroy_response
  (foreign-lambda
   void
   "MHD_destroy_response"
   (c-pointer (struct "MHD_Response"))))

 (define MHD_start_daemon
  (foreign-safe-lambda*
   (c-pointer (struct "MHD_Daemon"))
   ((unsigned-int flags)
    (unsigned-int port)
    (MHD_AcceptPolicyCallback apc)
    (c-pointer apc_cls)
    (MHD_AccessHandlerCallback dh)
    (c-pointer dh_cls)
    (int opt))
   "C_return(MHD_start_daemon(flags, port, apc, apc_cls, dh, dh_cls, opt));"))

 (define MHD_stop_daemon
  (foreign-lambda
   void
   "MHD_stop_daemon"
   (c-pointer (struct "MHD_Daemon"))))

 (define-foreign-variable MHD_RESPMEM_PERSISTENT_inner int "MHD_RESPMEM_PERSISTENT")
 (define-foreign-variable MHD_HTTP_OK_inner int "MHD_HTTP_OK")
 (define-foreign-variable MHD_USE_SELECT_INTERNALLY_inner int "MHD_USE_SELECT_INTERNALLY")
 (define-foreign-variable MHD_OPTION_END_inner int "MHD_OPTION_END")

 (define MHD_RESPMEM_PERSISTENT MHD_RESPMEM_PERSISTENT_inner)
 (define MHD_HTTP_OK MHD_HTTP_OK_inner)
 (define MHD_USE_SELECT_INTERNALLY MHD_USE_SELECT_INTERNALLY_inner)
 (define MHD_OPTION_END MHD_OPTION_END_inner)


)
