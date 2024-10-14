extension ListValue<T> on List<T> {
  bool isEqual(List<T> list) {
    return every((element) => list.contains(element));
  }
}

extension ListValueInt on List<int> {
  String get extractNfcIdentifier =>
      map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');
}
