#lang sicp
; Exercise 1.3.
; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

(define (max x y)
  (if (> x y) x y))

(define (square x) (* x x))

(define (sum-of-squares x y z)
  (cond ((and (> x y) (> x z)) (+ (square x) (square (max y z))))
        ((and (> y x) (> y z)) (+ (square y) (square (max x z))))
        (else (+ (square z) (square (max x y))))))

(sum-of-squares 1 2 3) ; 2^2 + 3^2 = 4 + 9 = 13