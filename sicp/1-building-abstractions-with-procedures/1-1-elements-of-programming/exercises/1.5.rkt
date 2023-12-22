#lang sicp
; Exercise 1.5
; Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; Then he evaluates the expression

(test 0 (p))

; Applicative-order means we substitute the values at each step:
; (test 0 (p)) ; Now we evaluate the arguments to test, which means we evaluate 0 and (p)
; (test 0 (p)) ; 0 evaluates to 0, (p) evaluates to (p)
; (test 0 (p)) ; 0 evaluates to 0, (p) evaluates to (p)
; ...
; This will never terminate, because we keep evaluating (p) and it keeps evaluating to (p).

; Normal-order means we substitute the values at the last possible moment:
; (test 0 (p)) ; Now we replace `test` with its definition
; (if (= 0 0) 0 (p)) ; `if` is a special form that stops evaluating as soon as it knows the answer. Since 0 = 0, we return 0, thus avoiding evaluating (p).
; 0
