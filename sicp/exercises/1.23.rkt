#lang sicp

; Exercise 1.23
; The smallest-divisor procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers.
; This suggests that the values used for test-divisor should not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ... .
; To implement this change, define a procedure next that returns 3 if its input is equal to 2 and otherwise returns its input plus 2.
; Modify the smallest-divisor procedure to use (next test-divisor) instead of (+ test-divisor 1). With timed-prime-test incorporating this modified version of smallest-divisor, run the test for each of the 12 primes found in exercise 1.22.
; Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      #f))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))


(define (square x) (* x x))
(define (next x)
  (if (= x 2)
      3
      (+ x 2)))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (search-for-primes n counter)
  (define (iter n counter)
    (if (> counter 0)
        (if (timed-prime-test n)
            (iter (+ n 2) (- counter 1))
            (iter (+ n 2) counter))
        'COMPUTATION\ COMPLETE))
  (if (even? n)
      (iter (+ n 1) counter)
      (iter n counter)))

; sqrt(10) ~ 3.16
(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)
(search-for-primes 1000000000 3)
(search-for-primes 10000000000 3)

; | start       | time      | ex. 1.22 time  |
; | 1000        |  0-1ms    |      0-1ms     |
; | 10000       |  0-1ms    |      0-1ms     |
; | 100000      |  1ms      |      1ms       |
; | 1000000     |  1-3ms    |      3ms       |
; | 10000000    |  6ms      |      10ms      |
; | 100000000   |  18ms     |      30-32ms   |
; | 1000000000  |  55-57ms  |      120ms     |
; | 10000000000 |  ~170ms   |      314ms     |

; We can observe a ~ x2 speedup for the tests with input > 10^6-10^7. This can be explained by the fact that the number of numbers that `next` has to check is halved.