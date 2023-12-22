# 1.2 Procedures and the Processes They Generate

> A procedure is a pattern for the local evolution of a computational process. It specifies how each stage of the process is built upon the previous stage. We would like to be able to make statements about the overall, or global, behavior of a process whose local evolution has been specified by a procedure. This is very difficult to do in general, but we can at least try to describe some typical patterns of process evolution.

In this chapter, we will talk about the time and space complexity of procedures.

## 1.2.1 Linear Recursion and Iteration

```scheme
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

We can visualize the process of computing `(factorial 6)` using the substitution model:

```scheme
(factorial 6)
(* 6 (factorial 5))
(* 6 (* 5 (factorial 4)))
(* 6 (* 5 (* 4 (factorial 3))))
(* 6 (* 5 (* 4 (* 3 (factorial 2)))))
(* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
(* 6 (* 5 (* 4 (* 3 (* 2 1)))))
(* 6 (* 5 (* 4 (* 3 2))))
(* 6 (* 5 (* 4 6)))
(* 6 (* 5 24))
(* 6 120)
720
```

This method is quite inefficient because it takes a lot of space to store the intermediate results. We can do better by using a running product approach:

```scheme
(define (factorial n)
  ; We need multiple accumulator parameters. One for the product and one for the counter.
  ; Max counter stays the same, and is used to terminate the recursion.
  (define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))

  (fact-iter 1 1 n))
```


We can visualize the process of computing `(factorial 6)` using the substitution model:

```scheme
(factorial 6)
(fact-iter 1 1 6)
(fact-iter 1 2 6)
(fact-iter 2 3 6)
(fact-iter 6 4 6)
(fact-iter 24 5 6)
(fact-iter 120 6 6)
(fact-iter 720 7 6)
720
```

A **linear recursive process** is a process whose number of deferred operations grows linearly with the input, but the number of steps for each operation is constant (1).

A **linear iterative process** is a process whose number of steps grows linearly with the input, but the number of deferred operations is constant (1).

We must not confuse a recursive process with a recursive procedure. A recursive procedure is one that is defined in terms of itself, while a recursive process describes how a process evolves. For example, `fact-iter` is a recursive procedure, but it generates an iterative process.

Scheme implementations are required to be tail-recursive, which means that whenever a procedure returns, it does so by returning the value of a call to itself. This allows us to implement iterative processes in a recursive style. This guarantees that an iterative process will execute in constant space, even if the iterative procedure is described by a recursive procedure.

Tail recursion is a compiler optimization trick.

## 1.2.2 Tree Recursion

![The tree-recursive process generated in computing (fib 5).](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/ch1-Z-G-13.gif)

For this process, the time complexity grows with the number of nodes in above tree (exponential with the input), while the space complexity grows with the depth of the tree (linear with the input).

`fib(n)` is the closest integer to $\phi^n / \sqrt{5}$, where $\phi = (1 + \sqrt{5}) / 2$. This is called the *golden ratio*, which approximates to 1.6180. The golden ratio satisfies the equation $\phi^2 = \phi + 1$.

### Example: Counting change
See [1-2-count-change.rkt](1-2-count-change.rkt).

> Memoization (or tabulation) can sometimes be used to transform processes that require an exponential number of steps (such as count-change) into processes whose space and time requirements grow linearly with the input.

## 1.2.3 Orders of Growth

Let's consider $n$ as the size of the problem that we analyze, and $R(n)$ as the amount of resources that the process requires for the problem.

$n$ can be different for different types of problem e.g. it can be the accurate digits when we are computing square roots, or it can be the number of elements in a list when we are sorting it (most of the time, we will use the number of elements in a list). $R(n)$ can be the number of registers used, the number of elementary machine operations performed, or the amount of memory needed.

> We say that $R(n)$ has order of growth $\Theta(f(n))$ if there are positive constants $k_1$ and $k_2$ such that $k_1 f(n) \leq R(n) \leq k_2 f(n)$ for any sufficiently large value of $n$.

The order of growth is also useful when (besides its use in ranking algorithms) we want to, let's say, double the size of our input. If we know that the order of growth is $\Theta(n^2)$, then we know that the amount of resources required will be 4 times the amount of resources required for the original input.

## 1.2.4 Exponentiation

The normal algorithm will yield a linear recursive process, meaning time complexity of $\Theta(n)$ and space complexity of $\Theta(1)$.

We can use successive squaring to compute exponentiation in logarithmic time. The idea is to use the following equations:

$$
a^n = \begin{cases}
  (a^{n/2})^2 & \text{if $n$ is even} \\
  a \cdot a^{n-1} & \text{if $n$ is odd}
\end{cases}
$$

This will yield a logarithmic recursive process, meaning time complexity of $\Theta(\log n)$ and space complexity of $\Theta(1)$.

See [1.16.rkt](exercises/1.16.rkt) for an implementation of the iterative version of this algorithm.

## 1.2.5 Greatest Common Divisors

The greatest common divisor (GCD) of two integers $a$ and $b$ is the largest integer that divides both $a$ and $b$ with no remainder.

We can use the following equations to compute the GCD:

$$
\begin{align}
  gcd(a, b) &= gcd(b, a \mod b) \\
  gcd(a, 0) &= a
\end{align}
$$

To determine the order of growth of this algorithm, we can use Lamé's theorem:

> Lamé's theorem: If Euclid's Algorithm requires $k$ steps to compute the GCD of some pair, then the smaller number in the pair must be greater than or equal to the $k$-th Fibonacci number, $Fib(k)$.

Let $n$ be the smaller number in the pair. If Euclid's Algorithms process takes $k$ steps, then we must have $n \geq Fib(k) \approx \phi^k / \sqrt{5}$. Also, if we have $k$ steps, then the process must grow by at least a factor of $\phi$ each step. Therefore, the number of steps $k$ must be approximately $\log_\phi n$, which means that the order of growth is $\Theta(\log n)$.

## 1.2.6 Example: Testing for Primality

We have 2 algorithms for testing primality:
1. The first one is to test whether $n$ is divisible by any integer between 2 and $\sqrt{n}$. This algorithm has a time complexity of $\Theta(\sqrt{n})$.
2. The second one is a probabilistic one, called the Fermat test. It says that if $n$ is prime, then for any integer $a$ in the range $1 < a < n$, we have $a^n \equiv a \mod n$, meaning that $a^n$ and $a$ have the same remainder when divided by $n$. This algorithm has a time complexity of $\Theta(\log n)$.

For the first one, please see [1-2-prime-linear.rkt](1-2-prime-linear.rkt). For the second one, please see [1-2-prime-log.rkt](1-2-prime-log.rkt).

To understand the primality testing algorithm which uses the Fermat test, you have to think of the halving 

### Probabilistic methods

There are numbers that pass the Fermat test but are not prime.

> Numbers that fool the Fermat test are called Carmichael numbers, and little is known about them other than that they are extremely rare. There are 255 Carmichael numbers below 100,000,000. The smallest few are 561, 1105, 1729, 2465, 2821, and 6601. In testing primality of very large numbers chosen at random, the chance of stumbling upon a value that fools the Fermat test is less than the chance that cosmic radiation will cause the computer to make an error in carrying out a ``correct'' algorithm. Considering an algorithm to be inadequate for the first reason but not for the second illustrates the difference between mathematics and engineering.

These probabilistic methods are useful in the cryptography field. For example, the RSA algorithm uses the fact that it is easy to compute the product of two large prime numbers, but it is very difficult to factor a large number into its prime factors. The RSA algorithm uses the Fermat test to check if a large number is prime.