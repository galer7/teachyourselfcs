#lang sicp
; Exercise 1.8
; Newton's method for cube roots is based on the fact that if y is an approximation to the cube root of x, then a better approximation is given by the value

(define (abs x)
  (if (< x 0) (- x) x))
(define (square x)
  (* x x))
(define (cube x)
  (* x x x))

(define (improve guess x)
  (/
    (+
      (/ x (square guess))
      (* 2 guess))
    3))
(define (good-enough? guess x)
  (< (abs (- (cube guess) x)) 0.001)) ; 0.001 is the tolerance
(define (cube-root-iter guess x)
  (if (good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x)) ; Start with a guess of 1.0

; We had to use cube in the good-enough? predicate because the cube of the guess is what we are comparing to x. If we used square, we would be comparing the square of the guess to the cube of x, which is not what we want.

(display "cube-root(8) = ") (cube-root 8)
(display "cube-root(27) = ") (cube-root 27)
(display "cube-root(64) = ") (cube-root 64)
(display "cube-root(cube(5)) = ") (cube-root (cube 5))
