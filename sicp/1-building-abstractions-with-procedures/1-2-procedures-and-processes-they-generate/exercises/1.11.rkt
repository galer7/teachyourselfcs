#lang sicp

; Exercise 1.11.
; A function f is defined by the rule that
; f(n) = n if n < 3 and
; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n >= 3.
; Write a procedure that computes f by means of a recursive process.
; Write a procedure that computes f by means of an iterative process.

(define (f-rec n)
  (if (< n 3)
    n
    (+ (f-rec (- n 1))
      (* 2 (f-rec (- n 2)))
      (* 3 (f-rec (- n 3))))))

(define (f-iter n)
  (define (f-iter-step count last1 last2 last3)
    (if (> count n)
      last1
      (f-iter-step
        (+ count 1)
        (+  last1
            (* 2 last2)
            (* 3 last3))
        last1
        last2)))
    
  (if (< n 3)
    n
    (f-iter-step 3 2 1 0))
)

(f-rec 3) ; 2 + 2*1 + 3*0 = 4
(f-rec 4) ; 4 + 2*2 + 3*1 = 11
(f-rec 5) ; 11 + 2*4 + 3*2 = 25

(f-iter 0) ; 0
(f-iter 1) ; 1
(f-iter 2) ; 2
(f-iter 3) ; 4
(f-iter 4) ; 11
(f-iter 5) ; 25