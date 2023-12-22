#lang sicp

; Exercise 1.25
; Alyssa P. Hacker complains that we went to a lot of extra work in writing expmod. After all, she says, since we already know how to compute exponentials, we could have simply written

; (define (expmod base exp m)
;   (remainder (fast-expt base exp) m))

; Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

; Solution:

; Comparing the 2 methods:

; expmod from 1.24:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; expmod using fast-expt:
(define (expmod-with-fast-expt base exp m)
  (remainder (fast-expt base exp) m))

; The expomod procedure using the fast-expt computes large numbers, thus taking a lot of time to compute. The expmod procedure from 1.24 is more efficient, since it uses the remainder procedure to compute the remainder, which is much faster than computing the exponentiation directly.

(define (fast-expt b n)
  (define (fast-expt-iter current-exp acc)
    (cond  ((= current-exp n) acc)
           ((even? n)
            (fast-expt-iter (+ current-exp (/ n 2)) (* acc (square b))))

           (else
            (fast-expt-iter (+ current-exp 1) (* acc b)))))

  (fast-expt-iter 0 1))

(define (even? n)
  (= (remainder n 2) 0))
(define (square x) (* x x))
