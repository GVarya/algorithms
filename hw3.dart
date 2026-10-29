import "dart:collection";

void main() {
  // 1 Найти корень числа. Работает за логарифм т.к. мы каждый раз уменьшаем область поиска в 2 раза. Границы определяются так: если квадрат искомого числа больше чем параметр на входе => двигаем правую границу, иначе левую, если квадрат равен параметру, значит мы ровно нашли корень
  print("1 binary search sqrt");
  print(binarySearchSqrt(16));
  print(binarySearchSqrt(26));
  
  // 2 Очень простая задача. Если мы выделяем определенное время, то один ксерокс успеет сделать T / x копий, а второй T / y копий. Если сумма (T / x) + (T / y) >= N, значит, за это время мы успеем сделать нужное количество копий.
  print("2 copy time");
  print(copyTime(3, 1, 2));
  print(copyTime(1, 4, 2));
  
  // 3 Накормить животных. Стратегия является оптимальной, потому что, отдавая самую маленькую подходящую порцию самому маленькому животному, мы сохраняем более крупные порции для более крупных животных. Это дает максимальное количество накормленных животных.
  print("3 feed animals");
  var animals = [3, 4, 7];
  var food = [8, 1, 2];
  print(feedAnimals(animals, food));
  
  animals = [3, 8, 1, 4];
  food = [1, 1, 2];
  print(feedAnimals(animals, food));
  
  animals = [1, 2, 2];
  food = [7, 1];
  print(feedAnimals(animals, food));
  
  animals = [8, 2, 3, 2];
  food = [1, 4, 3, 8];
  print(feedAnimals(animals, food));
  
  //4 Найти разницу между двух строк. В решении используется хеш-таблица для подсчета частоты символов.
  print("4 find extra letter");
  print(extraLetter("uio", "ueoi"));
  print(extraLetter("ab", "ab"));
  
  //5 сумма двух элементов для неотсортированного массива. Вместо того чтобы сравнивать каждый элемент с каждым, мы используем хеш-таблицу для хранения уже просмотренных чисел.
  print("5 two sum");
  var nums = [3, 8, 9, 11, 16, 18, 19, 21];
  print(twoSum(nums, 25));
  
  //6 массив аннограм
  print("6 group annagrams");
  List<String> strs = ["eat", "tea", "tan", "ate", "nat", "bat"];
  print(groupAnnagrams(strs));
  strs = ["won","now","aaa","ooo","ooo"];
  print(groupAnnagrams(strs));

}

//1.
int binarySearchSqrt(int num){
  int l = 0;
  int r = num;
  
  while(l <= r){
    int middle = (l + r) ~/ 2;
    if(middle * middle > num){
      r = middle - 1;
      continue;
    }
    if(middle * middle < num){
      l = middle + 1;
      continue;
    }
    return middle;
  }
  return r;
}

//2. 
int max(int x, int y){
  if (x > y){
    return x;
  } 
  return y;
}

int min(int x, int y){
  if (x < y){
    return x;
  } 
  return y;
}

int copyTime(int x, int y, int n){
  int l = 0;
  int r = (n - 1) * max(x, y);
  while (l + 1 < r){
    int middle = (l + r) ~/ 2;
    if((middle/x + middle/y) < (n -1) ){
      l = middle;
    } else{
      r = middle;
    }
  }
  return r + min(x, y);
}

//3.
int feedAnimals(List<int> animals, List<int> food){
  if(animals.isEmpty || food.isEmpty){
    return 0;
  }
  animals.sort();
  food.sort();
  int count = 0;
  for (int f in food){
    if(f >= animals[count]){
      count++;
    }
    if(count == animals.length){
      break;
    }
  }
  return count;
}

//4.
String extraLetter(String a, String b){
  Map<String, int> hashMapB = HashMap();
  for(int i = 0; i < b.length; i++){
    if(hashMapB.containsKey(b[i])){
          hashMapB[b[i]] = hashMapB[b[i]]! + 1;
    } else{
       hashMapB[b[i]] = 1;
    }
  }
  for(int i = 0; i < a.length; i++){
    hashMapB[a[i]] = hashMapB[a[i]]! - 1;
  }
  for(String key in hashMapB.keys){
    if(hashMapB[key]! > 0){
      return key;
    }
  }
  return "";
}

//5.
List<int?> twoSum(List<int> nums, int target){
  Map<int, int> cache = HashMap();
  for(int i = 0; i < nums.length; i++){
    cache[nums[i]] = i;
  }
  for(int i = 0; i < nums.length; i++){
    int diff = target - nums[i];
    if(cache.containsKey(diff)){
      return [i, cache[diff]];
    }
  }
  return [];
}

//6.
List<List<String>> groupAnnagrams(List<String> strs){
  Map<String, List<String>> annograms = HashMap();
  for(String s in strs){
    List<String> chars = s.split("");
    chars.sort();
    String sJoined = chars.join("");
    if (annograms.containsKey(sJoined)) {
      annograms[sJoined]!.add(s);
    } else {
      annograms[sJoined] = [s];
    }  
  }
  return annograms.values.toList();
  
}
