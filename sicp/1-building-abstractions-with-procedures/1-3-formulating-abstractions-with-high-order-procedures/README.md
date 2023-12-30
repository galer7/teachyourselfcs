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

## 1.3.2 Constructing Procedures Using `Lambda`

### Using `let` to create local variables

```scheme
(define (f x y)
  (define (square x) (* x x))
  (+ (square x) (square y)))
```

The above procedure can be rewritten using `let`:

```scheme
(define (f x y)
  (let ((square (lambda (x) (* x x))))
    (+ (square x) (square y))))
```

## 1.3.3 Procedures as General Methods

### Finding roots of equations by the half-interval method

We can use the half-interval method to find roots of equations. The half-interval method takes two values `a` and `b` such that `f(a)` and `f(b)` have opposite signs. It then keeps halving the interval until the interval is small enough.

```scheme
(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))
```

### Finding fixed points of functions

A number `x` is called a **fixed point** of a function `f` if `x` satisfies the equation `f(x) = x`. For some functions `f` we can locate the fixed points by beginning with an initial guess and applying `f` repeatedly:

$$ x, f(x), f(f(x)), f(f(f(x))), \cdots $$

We can stop when the value of `f(x)` is close enough to `x`.

```scheme
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
```