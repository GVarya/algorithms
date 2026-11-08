
void main() {
  // 1 Восстановление бинарного дерева из массива. Связь родитель потомок в массиве поределяется по формулам: левый потомок 2*i + 1 правый потомок 2*i + 2 где i индекс родителя в массиве. Для хранения узлов используется класс Node, он хранить значение в узле и ссылки на правый и левый потомок, я добавила в него для удобства метод печати.
  print("1 get tree from array.");
  print("test case 1");
  var treeArr = [8, 9, 11, 7, 16, 1, 3];
  var root = getTreeFromArr(treeArr, 0);
  root?.printTree();
  print("corner case 1");
  treeArr = [];
  root = getTreeFromArr(treeArr, 0);
  root?.printTree();
  print("corner case 2");
  treeArr = [1];
  root = getTreeFromArr(treeArr, 0);
  root?.printTree();
  
  //2 Симметричное бинарное дерево. Алгоритм идет методом обхода в ширину и за 1 цикл for проверяет 1 уровень и добавляет элементы следующего уровня, после этого срезает проверенный уровень из общего массива элементов. На каждом шаге сравниваются зеркальные элементы i и queue.length - i - 1. Узлы добавляются последовательно и соответственно зеркальное сравнение работает корректно.
  print("2 Symmetric tree.");
  print("test case 1");
  treeArr = [3, 8, 8, 9, 6, 6, 9];
  root = getTreeFromArr(treeArr, 0);
  print(isSymmetric(root));
  print("test case 2");
  treeArr = [3, 8, 8, 6, 9, 6, 9];
  root = getTreeFromArr(treeArr, 0);
  print(isSymmetric(root));
  print("corner case 1");
  treeArr = [];
  root = getTreeFromArr(treeArr, 0);
  print(isSymmetric(root));
  print("corner case 2");
  treeArr = [3];
  root = getTreeFromArr(treeArr, 0);
  print(isSymmetric(root));
  
  //3. Поиск минимальной глубины бинарного дерева. Поиск в ширину в этой задаче работает так: на каждом уровне мы ищем лист, если у текущего элемента нет потомков значит это лист и соответственно минимальная глубина дерева это глубина до этого элемента.
  print("3 min depth.");
  print("test case 1");
  treeArr = [3, 8, 8, 9];
  root = getTreeFromArr(treeArr, 0);
  print(minDepth(root));
  print("test case 2");
  treeArr = [3, 8, 8, 6, 9, 6];
  root = getTreeFromArr(treeArr, 0);
  print(minDepth(root));
  print("corner case 1");
  treeArr = [];
  root = getTreeFromArr(treeArr, 0);
  print(minDepth(root));
  print("corner case 2");
  treeArr = [3];
  root = getTreeFromArr(treeArr, 0);
  print(minDepth(root));

  //4. Поиск произведения максимального и минимального элементов. Поиск крайних элементов выполняется за O(h) т.к. мы не перебираем все дерево а спускаемся по двум конкретным веткам, самой левой (листом этой ветки будет минимальный элемент) и самой правой (лист - максимальный элемент), в худшем случае эти ветки являются самыми длинными и тогда поиск этих элементов будет O(h).
  print("4 min max multiplication.");
  print("test case 1");
  treeArr = [16, 12, 18, 11, 15, 17, 21];
  print(maxMinMult(treeArr));
  print("corner case 1");
  treeArr = [];
  print(maxMinMult(treeArr));
  
  //5. Сравнение двух бинарных деревьев. Деревья можно считать одинаковыми если в них одинаковое количество элементов и элементы занимают одинакове позиции.
  print("5 min max multiplication.");
  print("test case 1");
  treeArr = [3, 8, 8, 9];
  var treeArr2 = [3, 8, 8, 9];
  root = getTreeFromArr(treeArr, 0);
  var root2 = getTreeFromArr(treeArr2, 0);
  print(isSameTree(root, root2));
  print("test case 2");
  treeArr = [3, 8, 8, 9];
  treeArr2 = [3, 9, 8, 9];
  root = getTreeFromArr(treeArr, 0);
  root2 = getTreeFromArr(treeArr2, 0);
  print(isSameTree(root, root2));
  print("corner case 1");
  treeArr = [];
  treeArr2 = [3, 9, 8, 9];
  root = getTreeFromArr(treeArr, 0);
  root2 = getTreeFromArr(treeArr2, 0);
  print(isSameTree(root, root2));
  print("corner case 2");
  treeArr = [];
  treeArr2 = [];
  root = getTreeFromArr(treeArr, 0);
  root2 = getTreeFromArr(treeArr2, 0);
  print(isSameTree(root, root2));
}


class Node {
  int val;
  Node? right;
  Node? left;

  Node([this.val = 0, this.right = null, this.left = null]);
  
  void printTree([String prefix = '']) {
    right?.printTree('$prefix  ');
    print('$prefix$val');
    left?.printTree('$prefix  ');

  }
}

//1.
Node? getTreeFromArr(List<int> arr, int i){
  if(arr.isEmpty) return null;
  if(i > arr.length - 1) return null;
  
  var root = Node(arr[i]);
  root.right = getTreeFromArr(arr, i * 2 + 2);
  root.left = getTreeFromArr(arr, i * 2 + 1);
  
  return root;

}

//2.
bool isSymmetric(Node? root){
  if(root == null){
    return true;
  }
  List<Node?> queue = [root];
  while(queue.isNotEmpty){
    var queLen = queue.length;
    for(int i = 0; i < queLen; i++){
      if(queue[i] == null && queue[queLen - i - 1] == null){
        continue;
      }
      if(queue[i] == null || queue[queLen - i - 1] == null){
        return false;
      }
      if(queue[i]!.val != queue[queLen - i - 1]!.val){
        return false;
      }
      queue.add(queue[i]?.left);
      queue.add(queue[i]?.right);
    }
    queue = queue.sublist(queLen);
    
  }
  return true;
}

//3.
int minDepth(Node? root){
  if(root == null){
    return 0;
  }
  List<Node?> queue = [root];
  int depth = 0;
  while(queue.isNotEmpty){
    var queLen = queue.length;
    depth += 1;
    for(int i = 0; i < queLen; i++){
      if(queue[i] == null){
        continue;
      }
      if(queue[i]?.left == null && queue[i]?.right == null) return depth;
      queue.add(queue[i]?.left);
      queue.add(queue[i]?.right);
    }
    queue = queue.sublist(queLen);

  }
  return depth;
}

//4.
int maxMinMult(List<int> arr){
  if (arr.length < 3) return -1;
  int minIndex = 1;
  int maxIndex = 2;
  for(int i = 1; i < arr.length; i = i * 2 + 1){
    minIndex = i;
  }
  for(int i = 2; i < arr.length; i = i * 2 + 2){
    maxIndex = i;
  }
  return arr[minIndex] * arr[maxIndex];
}

//5.
bool isSameTree(Node? root1, Node? root2){
  if (root1 == null && root2 == null) return true;
  if(root1 == null || root2 == null) return false;
  if(root1.val != root2.val) return false;
  return isSameTree(root1.left, root2.left) && isSameTree(root1.right, root2.right);

}