import 'dart:math';

void main() {
  // 1 twoSum
  var nums = [3, 8, 9, 11, 16, 18, 19, 21];
  print("two sum 25: ${twoSum(nums, 25)}");

  // 2 reverse array
  var nums2 = [1, 2, 3, 4, 5];
  var nums3 = [1, 2, 3, 4];
  print("reverse array: ${reverseArray(nums2)}");
  print("reverse array: ${reverseArray(nums3)}");

  // 3 rotate array
  var nums4 = [1, 2, 3, 4, 5, 6, 7];
  print("rotate array: ${rotateArray(nums4, 3)}");

  // 4 merge sorted arrays
  var nums5 = [0, 2, 3, 5, 7];
  var nums6 = [1, 4, 5, 6, 7];
  print(mergeSortedArrays(nums5, nums6));
  
  // 5 merge sorted arrays
  print(mergeSortedArrays(nums5, nums6));
  
  // 6 min sub array
  var nums7 = [2, 3, 1, 2, 4, 3];
  print(minSubArray(nums7, 7));
  
  //7 sort binary array
  var nums8 = [0, 1, 1, 0, 1, 0, 1, 0];
  print(sortBinaryArray(nums8));
  
  //8 Sort Colors
  var colors = [2, 0, 2, 1, 1, 0];
  print(sortColors(colors));
  
  //9 sort even numbers
  var nums9 = [7, 3, 2, 4, 1, 11, 8, 9];
  print(evenFirst(nums9));
  
  //10 Non zero numbers first
  var nums10 = [0, 0, 1, 0, 3, 12];
  var nums11 = [0, 33, 57, 88, 60, 0, 0, 80, 99];
  var nums12 = [0, 0, 0, 18, 16, 0, 0, 77, 99];
  print(nonZeroesFirst(nums10));
  print(nonZeroesFirst(nums11));
  print(nonZeroesFirst(nums12));

}

// 1.
(int, int) twoSum(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;
  int sum = 0; // Имеет ли смысл выносить инициализацию за пределы цикла чтобы не инициализировать каждый раз?
  while (left < right) {
    sum = nums[left] + nums[right];
    if (sum > target) {
      right--;
    } else if (sum < target) {
      left++;
    } else {
      return (left, right);
    }
  }
  return (-1, -1);
}

// 2.
List<int> reverseArray(List<int> nums) {
  int left = 0;
  int right = nums.length - 1;
  int buff = 0;
  while (left < right) {
    buff = nums[left];
    nums[left] = nums[right];
    nums[right] = buff;
    left++;
    right--;
  }
  return nums;
}

//3.
void reversePart(List<int> nums, int left, int right) {
  int buff = 0;
  while (left < right) {
    buff = nums[right];
    nums[right] = nums[left];
    nums[left] = buff;
    right--;
    left++;
  }
}

List<int> rotateArray(List<int> nums, int k) {
  if (k > nums.length - 1) {
    k = k % nums.length;
  }
  reversePart(nums, 0, nums.length - 1);
  reversePart(nums, 0, k - 1);
  reversePart(nums, k, nums.length - 1);
  return nums;
}

//4.
List<int> mergeSortedArrays(List<int> nums1, List<int> nums2) {
  List<int> mergedNums = [];
  var ptr1 = 0;
  var ptr2 = 0;
  while (ptr1 < nums1.length && ptr2 < nums2.length) {
    if (nums1[ptr1] < nums2[ptr2]) {
      mergedNums.add(nums1[ptr1]);
      ptr1++;
    } else {
      mergedNums.add(nums2[ptr2]);
      ptr2++;
    }
  }
  for(int i = ptr1; i < nums1.length; i++){
    mergedNums.add(nums2[i]);
  }
  for(int i = ptr2; i < nums2.length; i++){
    mergedNums.add(nums2[i]);
  }
  return mergedNums;
}


//5.
List<int> mergeSortedArraysInPlace(List<int> nums1, List<int> nums2) {
  var ptr1 = nums1.length - nums2.length;
  var ptr2 = nums2.length - 1;
  var ptrEmpty = nums1.length - 1;
  
  while(ptr2 >= 0){
    if(nums1[ptr1] > nums2[ptr2]){
      nums1[ptrEmpty] = nums1[ptr1];
      ptrEmpty--;
      ptr1--;
    } else{
      nums2[ptrEmpty] = nums2[ptr2];
      ptrEmpty--;
      ptr2--;
    }
  }
  
  return nums1;
}


//6.
int minSubArray(List<int> nums, int target){
  int minLength = double.maxFinite.toInt();
  int left = 0;
  int curSum = 0;
  for(int right = 0; right < nums.length; right++){
    curSum += nums[right];
    while(curSum >= target){
      minLength = min(minLength, (right - left + 1));
      curSum -= nums[left];
      left++;
    }
    
  }
  return minLength != double.maxFinite.toInt() ? minLength : 0;
}


//7. 
List<int> sortBinaryArray(List<int> nums){
  int left = 0;
  int right = nums.length - 1;
  int buff = 0;
  while(left < right){
    if(nums[left] == 1 && nums[right] == 0){
      buff = nums[left];
      nums[left] = nums[right];
      nums[right] = buff;
      left++;
      right--;
    }
    else{
      if(nums[right] == 0){
        left++;
      } else{
        right--;
      }
    }
  }
  return nums;
}

// 8
void swap(int left, int right, List<int> nums){
  int buff = nums[left];
  nums[left] = nums[right];
  nums[right] = buff;
}

List<int> sortColors(List<int> colors){
  int low = 0;
  int mid = 0;
  int high = colors.length - 1;
  while(mid <= high){
    if(colors[mid] == 2){
      swap(mid, high, colors);
      high--;
    }
    else if(colors[mid] == 0){
      swap(low, mid, colors);
      low++;
      mid++;
    } else{
      mid++;
    }
  }
  return colors;
}

//9
List<int> evenFirst(List<int> nums){
  int evenIndex = 0;
  for(int i = 0; i < nums.length; i++){
    if(nums[i] % 2 == 0){
      swap(evenIndex, i, nums);
      evenIndex++;
    }
  }
  return nums;
}


//10 
List<int> nonZeroesFirst(List<int> nums){
  int nonZeroPtr = 0;
  for(int i = 0; i < nums.length; i++){
    if(nums[i] != 0){
      swap(i, nonZeroPtr, nums);
      nonZeroPtr++;
    }
  }
  
  return nums;
}