#lang sicp

; Exercise 1.27
; Demonstrate that the Carmichael numbers listed in footnote 47 really do fool the Fermat test. That is, write a procedure that takes an integer n and tests whether a^n is congruent to a modulo n for every a<n, and try your procedure on the given Carmichael numbers.

; The numbers are:
; 561, 1105, 1729, 2465, 2821, 6601

(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (test-carmichael n)
  (define (iter a)
    (cond ((= a n) true)
          ((= (expmod a n n) a) (iter (+ a 1)))
          (else false)))

  (iter 1))

; Test
(test-carmichael 561)   ; #t
(test-carmichael 1105)  ; #t
(test-carmichael 1729)  ; #t
(test-carmichael 2465)  ; #t
(test-carmichael 2821)  ; #t
(test-carmichael 6601)  ; #t