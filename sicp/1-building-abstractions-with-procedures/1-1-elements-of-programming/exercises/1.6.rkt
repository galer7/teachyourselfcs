#lang sicp
; Exercise 1.6
; Alyssa P. Hacker doesn't see why if needs to be provided as a special form. ``Why can't I just define it as an ordinary procedure in terms of cond?'' she asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of if:

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

; Eva demonstrates the program for Alyssa:

; (new-if (= 2 3) 0 5)
; 5

; (new-if (= 1 1) 0 5)
; 0

; Delighted, Alyssa uses new-if to rewrite the square-root program:

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

; What happens when Alyssa attempts to use this to compute square roots? Explain.

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

(define (sqrt x)
  (sqrt-iter 1.0 x)) ; Start with a guess of 1.0

(sqrt 9)

; The program will never terminate. The reason is that the new-if procedure is not a special form, so it will evaluate both the then-clause and the else-clause before passing them to the new-if procedure. This means that the recursive call to sqrt-iter will be evaluated before it is passed to new-if, and the program will never terminate.
; In reality you wouldn't write a procedure like new-if in the first place.

; Let's do some passes of the evaluator to see what happens:
; (sqrt 9)
; (sqrt-iter 1.0 9)
; (new-if (good-enough? 1.0 9)
;         1.0
;         (sqrt-iter (improve 1.0 9)
;                    9))
; 
; Starting from this point, we know that everything that we see here will be evaluated before it is we move on to the next step. It is trivial to see now why the program will never terminate.