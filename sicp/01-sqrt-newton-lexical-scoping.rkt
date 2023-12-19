#lang sicp

(define (average x y)
  (/ (+ x y) 2))
(define (abs x)
  (if (< x 0) (- x) x))
(define (square x)
  (* x x))

; By moving the definition of good-enough? inside the lexical scope of sqrt,
; we remove the redundant parameter x from the good-enough? procedure.
; Also, we don't need to worry about naming collisions with other procedures
; that might have a good-enough? procedure anymore.
(define (sqrt x)
  (define (improve guess)
    (average guess (/ x guess)))
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001)) ; 0.001 is the tolerance
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))

  (sqrt-iter 1.0)) ; Start with a guess of 1.0

(sqrt 9) ; 3.00009155413138
(square (sqrt 1000)) ; 1000.000369924366