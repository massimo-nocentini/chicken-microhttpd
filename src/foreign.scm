

(import scheme (chicken base) (chicken foreign) (chicken process) (chicken io) (chicken syntax))
(import-for-syntax (chicken format))

 (define-syntax to-string
  (syntax-rules ()
   ((to-string v) (symbol->string (quote v)))))

 (define-syntax in-string
  (syntax-rules ()
   ((in-string v) (string-append  "v" (string-append " world " (symbol->string (quote v)))))))

 (define-syntax make-str
  (er-macro-transformer
   (lambda (sexp rename compare)
    (let ((ty `(,(rename 'c-pointer) (,(rename 'struct) "zmq_pollitem_t"))))
     `(,(rename 'foreign-lambda*) ,ty ,(map (lambda (socket) `(,ty ,socket)) (cdr sexp))
         ,(string-append
             "zmq_pollitem_t items [] = {\n"
             (apply string-append (map (lambda (socket) 
                                        (format #f "{ ~a, 0, ZMQ_POLLIN, 0 },\n" 
                                         (symbol->string socket)))
                                   (cdr sexp)))
             " };
             C_return(items);"))))))
    
 (print (expand (make-str hello world)))
 (print (expand '(in-string pippo)))

(foreign-declare "#include <zmq.h>")

(define-foreign-type int-mappend (function int (int)))
;(define-external (foo (int x)) int (+ x 1))
(define-external (foo (int x)) int (+ x 1))

(let* ((my-strlen (foreign-lambda* int ((c-string str))
                   "int n = 0;
                   while(*(str++)) ++n;
                   C_return(n);"))
       (my-adder (foreign-safe-lambda* int ((int-mappend mappend) (int v))
                   "C_return((*mappend)(v));"))
       (code (make-str receiver controller))
       (ctor (make-str receiver controller))
       )
 (print (my-adder (location foo) 3))
 (print (my-strlen "one two three") (string? (to-string hello)))
 (print (in-string me))
 
 (let-values (((in-port out-port pid) (process "ps")))
  (print (read-string #f in-port)))
 
 )

