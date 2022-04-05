// write a recursive fucntion countDown(num) that prints the numbers from num to 0.
function countDown(num) {
  if (num <= 0) {
    return "Done!";
  } else {
    console.log(num);
    countDown(num - 1);
  }
}

countDown(4);
