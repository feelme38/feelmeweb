extension ListValue<T> on List<T> {
  bool isEqual(List<T> list) {
    return every((element) => list.contains(element));
  }
}

extension ListValueInt on List<int> {
  String get extractNfcIdentifier =>
      map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');
}

extension ListExtensions<T> on List<T> {
  List<T> filter(bool Function(T) predicate) {
    List<T> result = [];
    for (T element in this) {
      if (predicate(element)) {
        result.add(element);
      }
    }
    return result;
  }
}