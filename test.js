function findAllSubstrings(str, word) {
  let result = [];
  let wordLength = word.length;

  for (let i = 0; i < str.length; i++) {
    let subStr = str.substring(i, i + wordLength);
    if (subStr === word) {
      result.push(i);
    }
  }

  return result;
}

console.log("Super Simple");
console.log("Super Simple");
console.log("Super Simple");

console.log(findAllSubstrings("Super Simple", "Simple"));

let random_array = [1, 2, 3, 10];
console.log(random_array);

let stop = "Stop";
