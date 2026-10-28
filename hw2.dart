void main() {
  // 1. развернуь односвязный список. На каждом шаге меняется указатель для текущего элемента
  // следующий элемент становится предыдущим. Алгоритм работает за O(n) т.к. 1 один раз проходит по всему списку
  print("1 reverse list");
  var nums = LinkedList.fromList([0, 1, 2, 3, 4]);
  print(nums.head);
  print(reverseLinkedList(nums.head));

  //2. Найти середину спика. Быстрый указатель двигается в 2 раза быстрее чем медленный и когда быстрый дойдет до конца медленный как раз будет на середине
  print("2 find middle");
  var nums2 = LinkedList.fromList([0, 1, 2, 3, 4]);
  print(findMiddleNode(nums2.head));

  //3. Удалить элемент списка. Добавляем элемент перед первым, на случай если удалять надо будет первый. Идем по списку, ханим предыдущий и текущий узлы, если нашли элемент для удаления меняем указатель для предыдущего элемента на следующий от текущего
  print("3 remove element");
  var nums3 = LinkedList.fromList([0, 1, 2, 3, 4]);
  nums3.head = removeElement(nums2.head, 3);
  print(nums3);

  //4. Является ли строка подстрокой. Есть 2 указателя, 1 увеличивается только когда находит во второй строке элемент из своей строки, второй уеличивается всегда, если 1 указатель прошел по всей строке, и соответственно равен количеству символов в первой строке, значит он нашел во второй строке все символы из своей, значит 1 строка является подстрокой для 2
  print("4 subsequence");
  var a = "abc";
  var b = "asdbnmcpp";
  print(isSubsequence(a, b));
  print(isSubsequence(b, a));

  //5. Метод двух указателей. Уже решала эту задачку в прошлом ДЗ. Работает за O(n) т.к. 1 раз проходится по массиву.
  print("5 two sum");
  var nums4 = [3, 8, 9, 11, 16, 18, 19, 21];
  print("two sum 25: ${twoSum(nums4, 25)}");

  //6. Является ли строка палиндромом. 2 указателя, 1 вначале другой вконце на каждой итерации двигаем их друг к другу, если символы под указателями не равны, значит слово не палиндром, если указатели встретились  значит все проверки прошли и слово палиндром. ! раз проходим по строке => сложность O(n)
  print("6 is palindrome");
  var s1 = "abba";
  var s2 = "aba";
  var s3 = "dsff";
  print(isPalindrome(s1));
  print(isPalindrome(s2));
  print(isPalindrome(s3));
  
  //7 Удалить дубликаты. Два указателя медленный указывает на последний записанный элемент, быстрый идет по массиву и ищет первый не дубликат, если нашел, то к медленнному указателю прибавляется единица и в этот элемент массива записывается новое не дублированное значение
  print("7 remove dublicates");
  var nums5 = [1, 1, 2, 2, 3, 4, 4, 4, 5];
  print(replaceDublicates(nums5));
  
  //8 слить 2 отсортированных списка. Работает за O(n+m) потому что нам фактически надо пройти по двум массивам и переставить всем указатели если длина одного n а другого m затраты по времени будут n+m. Память за O(1) потому что мы не создаем новых списков, мы меняем указатели у уже существующих узлов это не требует доп. памяти
  var list1 = LinkedList.fromList([4, 7, 9, 11]);
  var list2 = LinkedList.fromList([3, 6, 8]);
  list1.head = mergeLinkedLists(list1.head, list2.head);
  print(list1);

}

// 2 вспомогательных класса узел односвязного списка и сам список
class ListNode<T> {
  T value;
  ListNode<T>? next;

  ListNode(this.value, [this.next]);

  @override
  String toString() {
    String nextValue = next != null ? next!.value.toString() : 'null';
    return '$value -> $nextValue';
  }
}

class LinkedList<T> {
  ListNode<T>? head;

  LinkedList();

  factory LinkedList.fromList(List<T> values) {
    final list = LinkedList<T>();
    if (values.isEmpty) return list;

    list.head = ListNode<T>(values[0]);
    ListNode<T>? current = list.head;

    for (int i = 1; i < values.length; i++) {
      current!.next = ListNode<T>(values[i]);
      current = current.next;
    }
    return list;
  }

  void append(T value) {
    if (head == null) {
      head = ListNode<T>(value);
      return;
    }
    ListNode<T>? current = head;
    while (current!.next != null) {
      current = current.next;
    }
    current.next = ListNode<T>(value);
  }

  @override
  String toString() {
    var nums = [];
    var curr = head;
    while (curr != null) {
      nums.add(curr);
      curr = curr.next;
    }
    return nums.toString();
  }
}

//1.
ListNode<int>? reverseLinkedList(ListNode<int>? head) {
  var prev = null;
  ListNode<int>? current = head;
  while (current != null) {
    ListNode<int>? next = current.next;
    current.next = prev;
    prev = current;
    current = next;
  }
  head = prev;
  return head;
}

//2.
ListNode<int>? findMiddleNode(ListNode<int>? head) {
  var slow = head;
  var fast = head;
  while (fast != null && fast.next != null) {
    slow = slow!.next;
    fast = fast.next!.next;
  }
  return slow;
}

//3.
ListNode<int>? removeElement(ListNode<int>? head, int val) {
  ListNode<int>? dummy = ListNode(0, head);
  var prev = dummy;
  var cur = head;
  while (cur != null) {
    if (cur.value == val) {
      prev.next = cur.next;
    } else {
      prev = cur;
    }
    cur = cur.next;
  }

  return dummy.next;
}

//4.
bool isSubsequence(String a, String b) {
  int i = 0;
  int j = 0;
  while (i < a.length && j < b.length) {
    if (a[i] == b[j]) {
      i++;
    }
    j++;
  }
  return i == a.length;
}

//5.
(int, int) twoSum(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;
  int sum = 0;
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

//6.
bool isPalindrome(String s) {
  int left = 0;
  int right = s.length - 1;
  while (left < right) {
    if (s[left] != s[right]) {
      return false;
    }
    left++;
    right--;
  }
  return true;
}

//7.
List<int> replaceDublicates(List<int> nums){
  int slow = 0;
  int fast = 1;
  while(fast < nums.length){
    if(nums[slow] != nums[fast]){
      slow++;
      nums[slow] = nums[fast];
    }
    fast++;
  }
  for(int i = slow + 1; i < nums.length; i++){
    nums[i] = 0;
  }

  return nums;
}

//8.
ListNode<int>? mergeLinkedLists(ListNode<int>? headR, ListNode<int>? headL){
  var curr = null;
  if(headR!.value < headL!.value){ // Предполагаю что на вход не могут поступить пустые указатели
    curr = headR;
    headR = headR.next;
  }else{
    curr = headL;
    headL = headL.next;
  }
  var newHead = curr;
  while(headR != null && headL != null){
    if(headR.value < headL.value){
      curr.next = headR;
      headR = headR.next;
    }else{
      curr.next = headL;
      headL = headL.next;
    }
    curr = curr.next;
  }
  if(headR != null){
    curr.next = headR;
  }
  if(headL != null){
    curr.next = headL;
  }
  return newHead;
}