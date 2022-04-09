# write a recursive fib() function that acepts an integer n and returns the nth value of the Fibonacci sequence.
# using memoization


def fib(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 2:
        return 1
    else:
        memo[n] = fib(n - 1, memo) + fib(n - 2, memo)
        return memo[n]
