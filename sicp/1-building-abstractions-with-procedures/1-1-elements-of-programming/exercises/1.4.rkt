#lang sicp
; Exercise 1.4
; Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; We can apply conditionals on the operator of a procedure, in this case we are applying the conditional on the + and - operators. If b is greater than 0, we apply + to a and b, otherwise we apply - to a and b.
; So, the name of the procedure is correct, it yields a + |b|