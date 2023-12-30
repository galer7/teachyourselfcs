#lang sicp

; Exercise 1.36
; Modify fixed-point so that it prints the sequence of approximations it generates, using the newline and display primitives shown in exercise 1.22. Then find a solution to x^x = 1000 by finding a fixed point of
; x -> log(1000)/log(x).
; (Use Scheme's primitive log procedure, which computes natural logarithms.) Compare the number of steps this takes with and without average damping. (Note that you cannot start fixed-point with a guess of 1, as this would cause division by log(1) = 0.)

(define (average x y)
  (/ (+ x y) 2))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display "Current guess: ") (display guess) (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (x-to-the-x x)
  (fixed-point (lambda (y) (/ (log 1000) (log y)))
               x))

; To come up with the average damping function, we need to average the current guess with the next guess.
; So if y -> x^x, then we need to average y with log(1000)/log(y).
; This gives us the following function:
; y -> (y + log(1000)/log(y)) / 2

(define (x-to-the-x-avg-damp x)
  (fixed-point (lambda (y) (average
                            y
                            (/ (log 1000) (log y))))
               x))

(x-to-the-x 2.0)          ; 33 steps
(x-to-the-x-avg-damp 2.0) ; 8 steps