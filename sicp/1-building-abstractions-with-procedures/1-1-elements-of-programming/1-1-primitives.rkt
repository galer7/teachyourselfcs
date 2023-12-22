#lang sicp

; Primitive expressions
(+ 21 35 12) ; 68
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6)) ; 57

(define a 3) ; a = 3
(define b (+ a 1)) ; b = 4

; Compound procedures
(define (square x) (* x x))

(square (square 3)) ; 81

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(sum-of-squares 3 4) ; 25

; Conditional expressions
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
