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

let stop = "Stop";
