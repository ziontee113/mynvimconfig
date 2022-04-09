// write a recursive fib() function that acepts an integer n and returns the nth value of the Fibonacci sequence.
// using memoization

function fib(n, memo = {}) {
  if (n <= 2) return 1;
  if (memo[n]) return memo[n];
  return (memo[n] = fib(n - 1, memo) + fib(n - 2, memo));
}

fib(10);

("finished!");
