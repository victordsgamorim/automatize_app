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
}