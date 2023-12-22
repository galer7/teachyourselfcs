#lang sicp

; Exercise 1.28
; One variant of the Fermat test that cannot be fooled is called the Miller-Rabin test (Miller 1976; Rabin 1980).
; This starts from an alternate form of Fermat's Little Theorem, which states that if n is a prime number and a is any positive integer less than n, then a raised to the (n - 1)st power is congruent to 1 modulo n.

; To test the primality of a number n by the Miller-Rabin test, we pick a random number a<n and raise a to the (n - 1)st power modulo n using the expmod procedure.
; However, whenever we perform the squaring step in expmod, we check to see if we have discovered a ``nontrivial square root of 1 modulo n'', that is, a number not equal to 1 or n - 1 whose square is equal to 1 modulo n.
; It is possible to prove that if such a nontrivial square root of 1 exists, then n is not prime. It is also possible to prove that if n is an odd number that is not prime, then, for at least half the numbers a<n, computing a^(n-1) in this way will reveal a nontrivial square root of 1 modulo n. (This is why the Miller-Rabin test cannot be fooled.)

; Modify the expmod procedure to signal if it discovers a nontrivial square root of 1, and use this to implement the Miller-Rabin test with a procedure analogous to fermat-test. Check your procedure by testing various known primes and non-primes.
; Hint: One convenient way to make expmod signal is to have it return 0.

(define (square x) (* x x))
(define (miller-rabin-test n rounds)
  (define (try-it rounds)
    (define a (+ 1 (random (- n 1))))
    (cond
      ((= rounds 0) #t)
      ((= (expmod a n n) a) (try-it (- rounds 1)))
      (else #f)))
  (define (expmod base e mod)
    (cond
      ((= e 0) 1)
      ((even? e) (square-with-mod-test (expmod base (/ e 2) mod) mod))
      (else (remainder (* base (expmod base (- e 1) mod)) mod))))
  (define (square-with-mod-test x mod)
    (define y (remainder (square x) mod))
    (if (and (= y 1) (not (= x 1)) (not (= x (- mod 1))))
        0
        y))
  (and (> n 1) (try-it rounds)))


(display "Testing the Carmichael numbers: ") (newline)
(display "test for 561: ") (display (miller-rabin-test 561 3)) (newline)
(display "test for 1105: ") (display (miller-rabin-test 1105 3)) (newline)
(display "test for 1729: ") (display (miller-rabin-test 1729 3)) (newline)
(display "test for 2465: ") (display (miller-rabin-test 2465 3)) (newline)
(display "test for 2821: ") (display (miller-rabin-test 2821 3)) (newline)
(display "test for 6601: ") (display (miller-rabin-test 6601 3)) (newline)

(display "Testing the primes: ") (newline)
(display "test for 2: ") (display (miller-rabin-test 2 3)) (newline)
(display "test for 3: ") (display (miller-rabin-test 3 3)) (newline)
(display "test for 5: ") (display (miller-rabin-test 5 3)) (newline)
(display "test for 7: ") (display (miller-rabin-test 7 3)) (newline)
(display "test for 11: ") (display (miller-rabin-test 11 3)) (newline)
(display "test for 13: ") (display (miller-rabin-test 13 3)) (newline)