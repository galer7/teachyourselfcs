#lang sicp

; Exercise 1.33
; You can obtain an even more general version of accumulate (exercise 1.32) by introducing the notion of a filter on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy a specified condition. The resulting filtered-accumulate abstraction takes the same arguments as accumulate, together with an additional predicate of one argument that specifies the filter. Write filtered-accumulate as a procedure.

(define (square x) (* x x))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (filtered-accumulate combiner null-value term a next b filter)
  (if (> a b)
      null-value
      (combiner
       (if (filter a) (term a) null-value)
       (filtered-accumulate combiner null-value term (next a) next b filter))))

; Show how to express the following using filtered-accumulate:

; a. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a prime? predicate already written)

(define (sum-of-squares-of-primes a b)
  (filtered-accumulate + 0 square a inc b prime?))

; b. the product of all the positive integers less than n that are relatively prime to n (i.e., all positive integers i < n such that GCD(i,n) = 1).

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product-relative-primes n)
  (define (relatively-prime? x)
    (= (gcd x n) 1))
  (filtered-accumulate * 1 identity 1 inc n relatively-prime?))

(sum-of-squares-of-primes 1 10) ; 1 + 2^2 + 3^2 + 5^2 + 7^2 = 1 + 4 + 9 + 25 + 49 = 88
(product-relative-primes 10)    ; 1 * 3 * 7 * 9 = 189