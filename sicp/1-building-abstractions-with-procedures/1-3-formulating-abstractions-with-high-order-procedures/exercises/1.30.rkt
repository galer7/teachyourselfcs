#lang sicp

; Exercise 1.30
; The sum procedure above generates a linear recursion. The procedure can be rewritten so that the sum is performed iteratively. Show how to do this by filling in the missing expressions in the following definition:

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))

  (iter a 0))

(define (identity x) x)
(define (inc x) (+ x 1))

(sum identity 1 inc 0)    ; 0
(sum identity 1 inc 1)    ; 1
(sum identity 1 inc 2)    ; 3
(sum identity 1 inc 10)   ; 55