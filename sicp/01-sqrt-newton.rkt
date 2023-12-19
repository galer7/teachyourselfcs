#lang sicp
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

(sqrt 9) ; 3.00009155413138
(square (sqrt 1000)) ; 1000.000369924366