# 1. Building Abstractions with Procedures

> Computational processes are abstract beings that inhabit computers. As they evolve, processes manipulate other abstract things called data. The evolution of a process is directed by a pattern of rules called a program. People create programs to direct processes. In effect, we conjure the spirits of the computer with our spells.

Lisp was invented by John McCarthy in the 1950s. It uses recursion equations as a model of computation. Lisp stands for "List Processing".

Lisp descriptions of processes, called procedures, can be represented as List data.

## 1.1 The Elements of Programming

Every powerful language has three mechanisms for accomplishing this:
1. **primitive expressions**, which represent the simplest entities the language is concerned with,
2. **means of combination**, by which compound elements are built from simpler ones, and
3. **means of abstraction**, by which compound elements can be named and manipulated as units.

We deal with 2 kinds of elements: procedures and data.

> Number representation in programming languages can differ quite a bit e.g. 6 divided by 2 is 3 or 3.0?

Lisp uses prefix notation, which is a way of writing arithmetic expressions in which the operator is written before the operands. e.g. (+ 2 3) is 5.

### 1.1.2 Naming and the Environment

The interpreter maintains a memory area called the environment. The environment holds the variables and their values, and we can use more than one environment at a time (will be discussed later).

### 1.1.3 Evaluating Combinations

To evaluate a combination, do the following:
1. Evaluate the subexpressions of the combination.
2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

![Building the subexpression tree](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/ch1-Z-G-1.gif)

> Providing an environment is an important role in our understanding of the program execution

We also have special forms, which are evaluated differently from combinations. e.g. `define` is a special form that associates a name with a value. These special forms are defining the syntax of the language.

### 1.1.4 Compound Procedures

We can define our own procedures using `define`:
`(define (<name> <formal parameters>) <body>)`

e.g. `(define (square x) (* x x))`. We cannot know if `square` was built into the interpreter or defined by the user (for now?).

### 1.1.5 The Substitution Model for Procedure Application

In order to evaluate a compound procedure using the substitution model, we evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.

e.g. `(square (+ 2 5))` is evaluated as follows:
1. Evaluate the operator `square` and the operands `(+ 2 5)` (given that we had defined `square` as `(define (square x) (* x x))` previously).
2. Substitute the operands `(+ 2 5)` for the formal parameter `x` in the body of the procedure `(* x x)`.

Over the course of the book, we will examine different models of how the interpreter works. The substitution model is the simplest one. In chapter 5, we will see a complete implementation of an interpreter for Scheme.

#### Applicative order versus normal order

In contrast to the substitution model (also known as application order), normal-order evaluation is a strategy in which arguments are not evaluated before they are substituted into the procedure. Instead, the expressions are substituted in their original form and then left to be evaluated whenever the interpreter gets around to it.

For all combinations that are modeled using the applicative-order evaluation, normal-order evaluation will produce the same value. However, the opposite is not true.

```scheme
(define a 3)

; Applicative-order evaluation
(sum-of-squares (+ a 1) (* a 2))
(sum-of-squares (+ 3 1) (* 3 2))
(+ (square 4) (square 6))
(+ (* 4 4) (* 6 6))
(+ 16 36)

; Normal-order evaluation
(sum-of-squares (+ a 1) (* a 2))
(+ (square (+ a 1)) (square (* a 2)))
(+ (* (+ a 1) (+ a 1)) (* (* a 2) (* a 2)))
(+ (* (+ 3 1) (+ 3 1)) (* (* 3 2) (* 3 2)))
(+ (* 4 4) (* 6 6))
(+ 16 36)
```

Lisp uses applicative-order evaluation, which means that all the arguments to procedures are evaluated when the procedure is applied. This helps because we can avoid evaluating the same subexpression more than once (observe the difference in the number of steps in the above example).

### 1.1.6 Conditional Expressions and Predicates

`(if <predicate> <consequent> <alternative>)`, `(and <e_1> ... <e_n>)` and `(or <e_1> ... <e_n>)` are special forms because the subexpressions are not necessarily all evaluated. For example, if the first subexpression of `and` evaluates to `false`, then the value of the entire `and` expression is `false` and the remaining subexpressions are not evaluated. Similarly, if the first subexpression of `or` evaluates to `true`, then the value of the entire `or` expression is `true` and the remaining subexpressions are not evaluated.

### 1.1.7 Example: Square Roots by Newton's Method

Declarative vs imperative knowledge:
- Math is the paradigm of declarative knowledge. A mathematical statement asserts a fact about the world.
- Computer programs, on the other hand, describe processes. They tell the computer to follow a sequence of steps.

To find the square root of a number `x`, we will use the Newton's method. We start with a guess `y` and improve it by taking the mean of `y` and `x/y`. We can repeat this process until we are satisfied with the accuracy of the result.

### 1.1.8 Procedures as Black-Box Abstractions

`sqrt-iter` is recursive because it is defined in terms of itself. The process of computing the square root is recursive because `sqrt-iter` is called as part of its own definition.

When we right code, we apply procedural decomposition, which means that we break down the problem into subproblems that are themselves instances of the same problem, and then we solve each subproblem by applying the same strategy.

For example, we can define the `square` method in multiple ways, that is not important to the `good-enough?` method. Similarly, we can define the `good-enough?` method in multiple ways, that is not important to the `sqrt-iter` method.

#### Local names

The procedure *binds* the local names to the values of the arguments and then executes the body of the procedure in the context of this binding. The names of the formal parameters of a procedure have a scope that extends throughout the body of the procedure. We say that the procedure definition binds its formal parameters. When we bind a formal parameter, a scope is created in which the formal parameter is bound to a particular value.

If a variable is not bound, we say that it is *free* e.g. `*` is a free variable in `(define (square x) (* x x))`.

#### Internal definitions and block structure

To avoid naming collisions, we can define a procedure inside another procedure. This is called *block structure*.

Doing this, we can also apply *lexical scoping*, which means that the scope of a procedure is the body of the procedure in which the procedure is defined. In JavaScript, this is called *closure*.

The idea of *block structure* first appeared in Algol 60.

## 1.2 Procedures and the Processes They Generate

> A procedure is a pattern for the local evolution of a computational process. It specifies how each stage of the process is built upon the previous stage. We would like to be able to make statements about the overall, or global, behavior of a process whose local evolution has been specified by a procedure. This is very difficult to do in general, but we can at least try to describe some typical patterns of process evolution.

In this chapter, we will talk about the time and space complexity of procedures.

### 1.2.1 Linear Recursion and Iteration

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

### 1.2.2 Tree Recursion

![The tree-recursive process generated in computing (fib 5).](https://mitp-content-server.mit.edu/books/content/sectbyfn/books_pres_0/6515/sicp.zip/full-text/book/ch1-Z-G-13.gif)

For this process, the time complexity grows with the number of nodes in above tree (exponential with the input), while the space complexity grows with the depth of the tree (linear with the input).

`fib(n)` is the closest integer to $\phi^n / \sqrt{5}$, where $\phi = (1 + \sqrt{5}) / 2$. This is called the *golden ratio*, which approximates to 1.6180. The golden ratio satisfies the equation $\phi^2 = \phi + 1$.

#### Example: Counting change
See [01.2-count-change.rkt](01.2-count-change.rkt).

> Memoization (or tabulation) can sometimes be used to transform processes that require an exponential number of steps (such as count-change) into processes whose space and time requirements grow linearly with the input.
