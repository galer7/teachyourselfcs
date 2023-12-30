#lang sicp

; Exercise 1.39
; A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:

; tan x = x / (1 - x^2 / (3 - x^2 / (5 - x^2 / (7 - x^2 / ...))))

; where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the tangent function based on Lambert's formula. K specifies the number of terms to compute, as in exercise 1.37.

(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

(define (tan-cf x k)
  (define (n i)
    (if (= i 1)
        x
        (- (* x x))))
  (define (d i)
    (- (* 2 i) 1))
  (cont-frac n d k))

(define pi 3.14159)

(tan-cf (/ pi 4) 10)  ; Real: 1.0. Approx: 1.0
(tan-cf 0 10)         ; Real: 0.0. Approx: 0.0
(tan-cf (/ pi 6) 10)  ; Real: 1/sqrt(3). Approx: 0.5773502691896257
(tan-cf (/ pi 3) 10)  ; Real: sqrt(3). Approx: 1.7320508075688772