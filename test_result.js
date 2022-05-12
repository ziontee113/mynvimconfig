// You have a couple small problems. The main one is that you are returning the wrong thing from your edge condition:

if (n < 2) {
  return n; // n is just a length; doesn't make sense to return it.
}

// `n` is the length, you really want to return the small array here:

if (n < 2) {
  return a; // return the array instead
}

// Also, you need to pass the *result* of the recursive call to your comp function. Right now you're just returning the original lists with:

comp(l, r);

// Something like this would work better:

let l_sort = q(l); //merge sort left array
let r_sort = q(r); //merge sort right array
return comp(l_sort, r_sort); // merge the arrays when recursion unwinds.

// And you need to `return` things for recursion to work.

// Put all together:

// <!-- begin snippet: js hide: false console: true babel: false -->

// <!-- language: lang-js -->

function q(a) {
  var start = 0;
  var n = a.length;
  var length = parseInt(n / 2);
  if (n < 2) {
    return a;
  }
  var l = [],
    r = [];
  for (i = 0; i < length; i++) {
    l[i] = a[i]; //left array
  }
  for (i = 0, j = length; j < n; i++, j++) {
    r[i] = a[j]; //right array
  }
  let l_sort = q(l); //merge sort left array
  let r_sort = q(r); //merge sort right array
  return comp(l_sort, r_sort);
}

function comp(l, r) {
  var k = [],
    m = 0,
    i = 0,
    j = 0;
  while (i < l.length && j < r.length) {
    if (l[i] < r[j]) {
      k[m] = l[i];
      i++;
      m++;
    } else {
      k[m] = r[j];
      j++;
      m++;
    }
  }
  while (i != l.length) {
    k[m] = l[i];
    m++;
    i++;
  }
  while (j != r.length) {
    k[m] = r[j];
    m++;
    j++;
  }
  return k;
}

console.log(q([4, 1, 5, 3]).join(","));
console.log(q([5, 4, 3, 2, 1]).join(","));
console.log(q([2, 3]).join(","));
console.log(q([3, 2]).join(","));
console.log(q([1]).join(","));

// <!-- end snippet -->
