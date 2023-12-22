#lang sicp
; Exercise 1.1.
; Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented.

10                  ; 10
(+ 5 3 4)           ; 12
(- 9 1)             ; 8
(/ 6 2)             ; 3
(+ (* 2 4) (- 4 6)) ; 6

(define a 3)        ; no output
(define b (+ a 1))  ; no output

(+ a b (* a b)) ; (+ 3 4 12) = 19
(= a b) ; #f
(if (and (> b a) (< b (* a b))) ; if 4 > 3 and 4 < 12, return 4 else return 5
    b
    a)

(cond ((= a 4) 6)         ; if 3 == 4, return 6
      ((= b 4) (+ 6 7 a)) ; if 4 == 4, return 16
      (else 25))          ; else return 25

(+ 2 (if (> b a) b a)) ; 2 + (if 4 > 3, return 4 else return 3) = 6

(* (cond ((> a b) a)  ; case 3 > 4, return 3
         ((< a b) b)  ; case 3 < 4, return 4
         (else -1))   ; else return -1
   (+ a 1))           ; (* 4 (+ 3 1)) = 16