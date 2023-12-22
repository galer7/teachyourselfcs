#lang sicp

; Exercise 1.24
; Modify the timed-prime-test procedure of exercise 1.22 to use fast-prime? (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has (log n) growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?

(define number-of-fermat-tests 10)
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (fast-prime? n number-of-fermat-tests)
      (report-prime (- (runtime) start-time))
      #f))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (square x) (* x x))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

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

(search-for-primes 1000 3)
(search-for-primes 10000 3)
(search-for-primes 100000 3)
(search-for-primes 1000000 3)
(search-for-primes 10000000 3)
(search-for-primes 100000000 3)
(search-for-primes 1000000000 3)

; | start       |  time   | ex. 1.23 time  | ex. 1.22 time  |
; | 1^3         |  1ms    |  0-1ms         |      0-1ms     |
; | 10000       |  1ms    |  0-1ms         |      0-1ms     |
; | 100000      |  1-2ms  |  1ms           |      1ms       |
; | 10^6        |  1-2ms  |  1-3ms         |      3ms       |
; | 10000000    |  1-2ms  |  6ms           |      10ms      |
; | 100000000   |  2ms    |  18ms          |      30-32ms   |
; | 10^9        |  2ms    |  55-57ms       |      120ms     |

; Note: Being a O(log n) algorithm, a increase of x10 in the input will
; result in a increase of constant time in the execution of the algorithm.

; Conclusion: the times obtain using the Fermat test using successive squaring exponentiation
; looks to be liniar with the number of Fermat tests we choose to perform for each potential prime.

; For example:
; For number-of-fermat-tests = 10, the time to test 10^9 is 5ms
; For number-of-fermat-tests = 20, the time to test 10^9 is 10ms