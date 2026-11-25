void main() {
  print("1. find len of max sorted subarray"); // решение работает за O(n) т.к. один раз проходится по массиву.текущая и макси
  var nums1 = [3, 2, 8, 9, 5, 10];
  print(findLIS(nums1));
  nums1 = [1, 2, 7, 9, 0, 10];
  print(findLIS(nums1));
  nums1 = [8, 8, 8, 8];
  print(findLIS(nums1));

  print("2. Pascal triangle"); //В первом цикле формирем каркас будущего ответа, задаем массивы нужной длины с единицами во втором цикле заполняем по алгоритму: текущий элемент это сумма элементов с индексами i - 1 и i для верхнего списка.
  print(pascalTriangle(0));
  print(pascalTriangle(1));
  print(pascalTriangle(6));

  print("3. coins"); //В первом цикле формирем каркас будущего ответа, задаем массивы нужной длины с единицами во втором цикле заполняем по алгоритму: текущий элемент это сумма элементов с индексами i - 1 и i для верхнего списка.
  nums1 = [0];
  print(coinChange(nums1, 1));
  nums1 = [];
  print(coinChange(nums1, 0));
  nums1 = [1, 2, 5];
  print(coinChange(nums1, 11));

  print("4. max palindrome"); //Делаем таблицу по строке и заполняем true false для палиндромов разных длинн. Сложность O(n^2) т.к. делаем табличку n*n.
  print(maxPalindrome(""));
  print(maxPalindrome("babad"));
  print(maxPalindrome("aaabbadfgfdaii"));
}

int max(int a, int b) {
  return a > b ? a : b;
}

int min(int a, int b) {
  return a < b ? a : b;
}

//1.
int findLIS(List<int> nums) {
  if (nums.isEmpty) return 0;
  if (nums.length == 1) return 1;
  int counter = 1;
  int maxCounter = 0;
  for (int i = 1; i < nums.length; i++) {
    if (nums[i] > nums[i - 1]) {
      counter++;
    } else {
      maxCounter = max(maxCounter, counter);
      counter = 1;
    }
  }
  return maxCounter;
}

//2
List<List<int>> pascalTriangle(int n) {
  List<List<int>> dp = [];
  for (int i = 1; i <= n; i++) {
    List<int> tmp = [];
    for (int j = 1; j <= i; j++) {
      tmp.add(1);
    }
    dp.add(tmp);
  }
  for (int i = 1; i < n; i++) {
    for (int j = 1; j < i; j++) {
      dp[i][j] = dp[i - 1][j - 1] + dp[i - 1][j];
    }
  }
  return dp;
}

//3
int coinChange(List<int> coins, int amount) {
  if (coins.isEmpty) return -1;
  int inf = 0x7FFFFFFFFFFFFFFF;
  final dp = List<int>.filled(amount + 1, inf);
  dp[0] = 0;
  for (int i = 1; i <= amount; i++) {
    for (int coin in coins) {
      if (coin <= i && dp[i - coin] != inf) {
        dp[i] = min(dp[i], dp[i - coin] + 1);
      }
    }
  }
  if (dp[amount] == 0x7FFFFFFFFFFFFFFF) {
    return -1;
  }
  return dp[amount];
}

//4
String maxPalindrome(String s) {
  final n = s.length;
  if (n < 2) return s;

  List<List<bool>> dp = [];
  for (int i = 0; i < n; i++) {
    dp.add(List<bool>.filled(n, false));
  }
  int start = 0;
  int maxLen = 1;

  for (int i = 0; i < n; i++) dp[i][i] = true;

  for (int len = 2; len <= n; len++) {
    for (int i = 0; i + len - 1 < n; i++) {
      final j = i + len - 1;
      if (s[i] == s[j] && (len == 2 || dp[i + 1][j - 1])) {
        dp[i][j] = true;
        if (len > maxLen) {
          maxLen = len;
          start = i;
        }
      }
    }
  }

  return s.substring(start, start + maxLen);
}
