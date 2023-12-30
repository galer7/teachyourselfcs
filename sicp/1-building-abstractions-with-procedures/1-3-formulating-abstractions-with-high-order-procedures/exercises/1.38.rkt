#lang sicp

; Exercise 1.38
; In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus Continuis, which included a continued fraction expansion for e - 2, where e is the base of the natural logarithms. In this fraction, the Ni are all 1, and the Di are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... Write a program that uses your cont-frac procedure from exercise 1.37 to approximate e, based on Euler's expansion.

(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

(define (e k)
  (+ 2 (cont-frac (lambda (i) 1.0)
                  (lambda (i) (if (= (remainder i 3) 2)
                                  (* 2 (/ (+ i 1) 3))
                                  1))
                  k)))

; Test for 2.71828
(display "e 1: ") (e 1)
(display "e 2: ") (e 2)
(display "e 3: ") (e 3)
(display "e 4: ") (e 4)
(display "e 5: ") (e 5)
(display "e 6: ") (e 6)
(display "e 7: ") (e 7)
(display "e 8: ") (e 8)
(display "e 9: ") (e 9)