#lang sicp

; Exercise 1.18
; Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

(define (double a)
  (* a 2))

(define (halve a)
  (/ a 2))

(define (even? a)
  (= (remainder a 2) 0))

(define (fast-mult a b)
  (define (fast-mult-iter counter acc)
    (cond ((= counter 0)    acc)
          ((even? counter)  (fast-mult-iter (- counter 2)   (+ acc (double a))))
          (else             (fast-mult-iter (- counter 1)   (+ acc a)))))

  (if (= b 0) 0 (fast-mult-iter b 0)))

(fast-mult 10 2)  ; 20
(fast-mult 3 3)   ; 9
(fast-mult 2 10)  ; 20
(fast-mult 0 10)  ; 0
(fast-mult 10 0)  ; 0