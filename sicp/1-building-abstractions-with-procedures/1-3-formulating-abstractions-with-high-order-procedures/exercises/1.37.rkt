#lang sicp

; Exercise 1.37
; a. An infinite continued fraction is an expression of the form
; f = N1 / (D1 + N2 / (D2 + N3 / (D3 + ...)))

; As an example, one can show that the infinite continued fraction expansion with the Ni and the Di all equal to 1 produces 1/phi, where phi is the golden ratio (described in section 1.2.2). One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation -- a so-called k-term finite continued fraction -- has the form
; f = N1 / (D1 + N2 / (D2 + ... (Nk / Dk)))

; Suppose that n and d are procedures of one argument (the term index i) that return the Ni and Di of the terms of the continued fraction. Define a procedure cont-frac such that evaluating (cont-frac n d k) computes the value of the k-term finite continued fraction. Check your procedure by approximating 1/phi using

; (cont-frac (lambda (i) 1.0)
;            (lambda (i) 1.0)
;            k)

; for successive values of k. How large must you make k in order to get an approximation that is accurate to 4 decimal places?

(define (cont-frac n d k)
  (define (iter i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

(define (phi n)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             n))

; We need to get to 1.6180

(display "phi 1:\t\t") (phi 1)
(display "phi 2:\t\t") (phi 2)
(display "phi 3:\t\t") (phi 3)
(display "phi 4:\t\t") (phi 4)
(display "phi 5:\t\t") (phi 5)
(display "phi 6:\t\t") (phi 6)
(display "phi 7:\t\t") (phi 7)
(display "phi 8:\t\t") (phi 8)
(display "phi 9:\t\t") (phi 9)
(display "phi 10:\t\t") (phi 10)
(display "phi 11:\t\t") (phi 11)

; Answer for point a: 11

; b. If your cont-frac procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

; Our cont-frac procedure generates a recursive process. To make one that generates an iterative process, we start from the last term and work our way back to the first term.

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

; Make sure we get the same results
(define phi-iter (lambda (n) (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) n)))

(display "phi-iter 11:\t") (display (phi-iter 11)) (newline)