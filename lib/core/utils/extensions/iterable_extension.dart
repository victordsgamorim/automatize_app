extension IterableExtensions<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this) {
      yield convert(index++, element);
    }
  }

  T? firstWhereOrNull(bool Function(T element) item) {
    try {
      return firstWhere(item);
    } catch (e) {
      return null;
    }
  }

  int binarySearch(T item, int Function(T, T) compare) {
    int low = 0;
    int high = length;

    List<T> list = toList(); // Convert Iterable to List

    while (low < high) {
      int mid = (low + high) ~/ 2;

      if (compare(list[mid], item) < 0) {
        low = mid + 1;
      } else {
        high = mid;
      }
    }

    return low;
  }

}