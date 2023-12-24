#lang sicp

; Exercise 1.31
; a. The sum procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures. Write an analogous procedure called product that returns the product of the values of a function at points over a given range. Show how to define factorial in terms of product. Also use product to compute approximations to  using the formula.

(define (identity x) x)
(define (inc x) (+ x 1))

(define (product term a next b)
  (define (iter a b result)
    (if (> a b)
        result
        (iter (next a) b (* result (term a)))))

  (iter a b 1))

(define (factorial n)
  (product identity 1 inc n))

(product identity 1 inc 4)  ; 1 * 2 * 3 * 4 = 24
(factorial 4)               ; 1 * 2 * 3 * 4 = 24

; 1 -> 2
; 2 -> 4
; 3 -> 4
; 4 -> 6
; 5 -> 6
; 6 -> 8
(define (numerator-pi-term x)
  (if (even? x)
      (+ x 2)
      (+ x 1)))

; 1 -> 3
; 2 -> 3
; 3 -> 5
; 4 -> 5
; 5 -> 7
; 6 -> 7
(define (denominator-pi-term x)
  (cond ((= x 1) 3.0)
        ((even? x) (+ x 1))
        (else (+ x 2.0))))

; We can rewrite the series as:
; 2/3 * 4/3 * 4/5 * 6/5 * 6/7 * 8/7 * ...

; So we can define pi-term as:
(define (pi limit)
  (define (pi-term x)
    (/ (numerator-pi-term x) (denominator-pi-term x)))

  (* 4 (product pi-term 1.0 inc limit)))

(pi 100)    ; 3.1570301764551654
(pi 1000)   ; 3.1431607055322552
(pi 10000)  ; 3.1417497057380084
(pi 100000) ; 3.141608361277941

; b. If your product procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.