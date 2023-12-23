# 1.3 Formulating Abstractions with Higher-Order Procedures

> Procedures that manipulate procedures as arguments are called **higher-order procedures**.

## 1.3.1 Procedures as Arguments

The sequence

$$ \frac{1}{1 \cdot 3} + \frac{1}{5 \cdot 7} + \frac{1}{9 \cdot 11} + \cdots $$

converges to $\frac{\pi}{8}$. It can be represented with the following procedure:

```scheme
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))
```

We can use the concept of **higher-order procedures** to abstract the pattern of the above procedure:

```scheme
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))
```

The above procedure takes four arguments:

- `term`: a procedure that computes the term to be added
- `a`: a procedure that computes the next value of `a`
- `next`: a procedure that computes the next value of `a`
- `b`: the upper bound of the summation

We can now define `pi-sum` in terms of `sum`:

```scheme
(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))
```

Using the `sum` procedure, we can define the integral of a function `f` between `a` and `b` as the area under the curve of `f` between `a` and `b`. The area can be approximated by the sum of the areas of rectangles with heights given by the function and widths given by `dx`:

$$ \int_a^b f(x) dx = \left[ f\left( a + \frac{dx}{2} \right) + f\left( a + dx + \frac{dx}{2} \right) + f\left( a + 2dx + \frac{dx}{2} \right) + \cdots \right] dx $$

```scheme
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))
```