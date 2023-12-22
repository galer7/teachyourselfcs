#lang sicp

; Exercise 1.26
; Louis Reasoner is having great difficulty doing exercise 1.24. His fast-prime? test seems to run more slowly than his prime? test. Louis calls his friend Eva Lu Ator over to help. When they examine Louis's code, they find that he has rewritten the expmod procedure to use an explicit multiplication, rather than calling square:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; ``I don't see what difference that could make,'' says Louis. ``I do.'' says Eva. ``By writing the procedure like that, you have transformed the (log n) process into a (n) process.'' Explain.

; Explanation:
; The only magic thing about expmod was that it used square to square the base. By removing that, we've lost the magic, and now we're just doing a linear number of multiplications, since we will need to evaluate each of the recursive calls to expmod.

; One could also say that we lost the tail recursion of the most important branch of the expmod procedure, which is the even? branch.