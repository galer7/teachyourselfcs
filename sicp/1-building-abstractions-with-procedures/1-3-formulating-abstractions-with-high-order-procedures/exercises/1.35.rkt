#lang sicp

; Exercise 1.35
; Show that the golden ratio phi (section 1.2.2) is a fixed point of the transformation
; x -> 1 + 1/x, and use this fact to compute phi by means of the fixed-point procedure.

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (phi x)
  (+ 1 (/ 1 x)))

(define (phi-fixed-point)
  (fixed-point phi 1.0))

(phi-fixed-point) ; 1.6180327868852458