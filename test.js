// Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
// You may assume that each input would have exactly one solution, and you may not use the same element twice.
// You can return the answer in any order.

function twoSum(nums, target) {
  let hash = {};

  for (let i = 0; i < nums.length; i++) {
    let complement = target - nums[i];
    if (hash[complement] !== undefined) return [hash[complement], i];

    hash[nums[i]] = i;
  }
}

twoSum([15, 2, 11, 7, 7], 9);

// improve the time complexity, given a sorted array

function twoSum(nums, target) {
  nums.sort((a, b) => a - b);

  let left = 0;
  let right = nums.length - 1;

  while (left < right) {
    let sum = nums[left] + nums[right];

    if (sum === target) return [left, right];
    else if (sum < target) left++;
    else right--;
  }
}

console.log("hello world!!!");

// time complexity = O(n)
[15, -2, 2, 11, 7, -2].sort((a, b) => a - b);
twoSum([15, -2, 2, 11, 7, -2], 9);

console.log("end of script");
