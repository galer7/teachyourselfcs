#lang sicp

; Exercise 1.41
; Define a procedure double that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if inc is a procedure that adds 1 to its argument, then (double inc) should be a procedure that adds 2. What value is returned by

(define (double f)
  (lambda (x) (f (f x))))

(((double (double double)) inc) 5) ; 21 = 5 + 16

; inc will be called 16 times, but I don't get why right now