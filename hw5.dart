import "dart:collection";
import 'dart:math';

// import 'package:collection/collection.dart';

void main() {
  //1 Полное бинарное дерево. Способ обхода BFS. Идем по уровням, если встречаем null ставим отметку, добавляем сначала левое поддерево потом правое поэтому обход слева на право и если после отметки встречаем не null значит дерево неполное.
  print("Complete binary tree");
  Node leaf11 = Node(11);
  Node leaf6 = Node(6);
  Node leaf9 = Node(9);
  Node node3_leftTree = Node(3, leaf6, leaf11);
  Node root1 = Node(8, node3_leftTree, leaf9);
  print(isCompleteTree(root1));

  Node leaf6_2 = Node(6);
  Node leaf9_2 = Node(9);
  Node node3_rightTree = Node(
    3,
    null,
    leaf6_2,
  ); // неполное дерево, null потомок левый при не null правом
  Node root2 = Node(8, leaf9_2, node3_rightTree);
  print(isCompleteTree(root2));

  //2. Объединение K отсортированных массивов. Сложность алгоритма O(N logN) т.к. при перестройке кучит требуется в среднем logN, добавление элемента в кучу O(N). Итого O(N + N logN) = O(N logN)
  print("merge K sorted arrays");
  var arr = [
    [0, 1, 3, 6, 8, 9],
    [6, 7, 10, 11, 25, 45],
    [2, 4, 5, 6],
  ];
  print(mergeKArrays(arr));

  //3 K-ый наименьший / наибольший элемент. Решение для наименьшего, чтобы работало с наибольшим надо изменить тип кучи. Сложность O(n logn)
  print("k Smallest Element In Array");
  var arr2 = [0, 3, 4, 5, 1, 7];
  print(kSmallestElementInArray(arr2, 3));

  //4. Обход в глубину и рекурсивное увеличение счетчика, если дошел до k возвращаем результат
  print("k Min Element In BST");
  final root = Node(5, Node(3, Node(2), Node(4)), Node(8, Node(7), Node(9)));
  print(kMinElementInBST(root, 3, Counter()));

  //5. Balance factor. Высота вычисляется рекурсивно как максимум из высот поддеревьев + 1, у листев высота ноль.
  print("Balance factor");
  print(calculateHeightAndBalance(root));

  //6.Преобразование в зеркальное дерево. Рекурсивно меняем левого и правого потомка для каждого узла временная сложность O(N)
  print("Mirror tree");
  root.printTree();
  mirrorTree(root)!.printTree();
}

class Node {
  int val;
  Node? right;
  Node? left;
  int balanceFaactor = 0;

  Node([this.val = 0, this.left = null, this.right = null]);

  void printTree([String prefix = '']) {
    right?.printTree('$prefix  ');
    print('$prefix$val');
    left?.printTree('$prefix  ');
  }
}

//1.
bool isCompleteTree(Node? root) {
  if (root == null) return true;
  bool seenNull = false;
  Queue<Node?> queue = Queue<Node?>();
  queue.addLast(root);
  while (queue.length > 0) {
    var node = queue.removeFirst();
    if (node == null) {
      seenNull = true;
    } else {
      if (seenNull) return false;
      queue.addLast(node.left);
      queue.addLast(node.right);
    }
  }
  return true;
}

//2.
List<int> mergeKArrays(List<List<int>> arrays) {
  var heap = HeapPriorityQueue<int>(); // куча в Dart по умолчанию мин куча
  for (var list in arrays) {
    heap.addAll(list);
  }
  List<int> result = [];
  while (heap.size > 0) {
    result.add(heap.removeFirst());
  }
  return result;
}

//3.
int kSmallestElementInArray(List<int> arr, int k) {
  var heap = HeapPriorityQueue<int>();
  heap.addAll(arr);
  for (int i = 0; i < k - 1; i++) {
    heap.removeFirst();
  }
  return heap.removeFirst();
}

//4.
class Counter {
  int value = 0;
}

int? kMinElementInBST(Node? root, int k, Counter counter) {
  if (root == null) return null;
  var leftRes = kMinElementInBST(root.left, k, counter);
  if (leftRes != null) return leftRes;
  counter.value++;
  if (counter.value == k) {
    return root.val;
  }
  return kMinElementInBST(root.right, k, counter);
}

//5.
int calculateHeightAndBalance(Node? root) {
  if (root == null) return 0;
  var leftHeight = calculateHeightAndBalance(root.left);
  var rightHeight = calculateHeightAndBalance(root.right);
  root.balanceFaactor = leftHeight - rightHeight;

  return 1 + max(leftHeight, rightHeight);
}

//6.
Node? mirrorTree(Node? root) {
  if (root == null) return null;
  var buff = root.left;
  root.left = root.right;
  root.right = buff;
  mirrorTree(root.left);
  mirrorTree(root.right);
  return root;
}
