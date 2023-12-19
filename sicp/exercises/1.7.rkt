#lang sicp
; Exercise 1.7
; The good-enough? test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing good-enough? is to watch how guess changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

(define (abs x)
  (if (< x 0) (- x) x))
(define (square x)
  (* x x))
(define (improve guess x)
  (average guess (/ x guess)))
(define (average x y)
  (/ (+ x y) 2))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001)) ; 0.001 is the tolerance

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x)) ; Start with a guess of 1.0

(display "Current sqrt implementation tests:\n")
(display "sqrt(0.000000000000005) = ") (sqrt 0.000000000000005)
(display "sqrt(9999999999999999.7321) = ") (sqrt 9999999999999999.7321)

; From my tests, it seems that the good-enough? test fails for small numbers, but works for large numbers.
; The reason for this is that the tolerance is set to 0.001, which is too large for small numbers.

(define (better-good-enough? new-guess old-guess x)
  (< (abs (- new-guess old-guess)) (/ x 1000))) ; 0.001% of x is the tolerance

(define (better-sqrt-iter guess x)
  (if (better-good-enough? (improve guess x) guess x)
      guess
      (better-sqrt-iter (improve guess x) x)))

(define (better-sqrt x)
  (better-sqrt-iter 1.0 x)) ; Start with a guess of 1.0

(display "Better sqrt tests:\n")
(display "sqrt(0.000000000000005) = ") (better-sqrt 0.000000000000005)
(display "sqrt(9999999999999999.7321) = ") (better-sqrt 9999999999999999.7321)

; This implementation works better for small numbers, but still fails for large numbers.
; The reason for this is that the tolerance is set to 0.001% of x, which is too large for large numbers.