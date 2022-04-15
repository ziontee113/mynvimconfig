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

console.log(1 + 55);

let random_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

let stop = "Stop";
