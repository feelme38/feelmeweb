
extension S on String {
  bool get hasSpacer => contains(' ');

  bool get hasNumerics => double.tryParse(this) != null;

  String format(String param) {
    return replaceAll('{}', param);
  }

  bool containsValue(String? value) {
    return getSearchString().contains(value.orEmpty.getSearchString());
  }

  bool get isValid => replaceAll(' ', '')
      .replaceAll('\n', '')
      .isNotEmpty;

  String intFormat(int param) {
    return replaceAll('{}', '$param');
  }

  String formatWithFinish(int param) {
    if (param != 12 && param != 13 && param != 14) {
      if (param.toString().endsWith('2') ||
          param.toString().endsWith('3') ||
          param.toString().endsWith('4')) {
        return replaceAll('~~', 'я');
      }
    }
    if (param.toString().endsWith('1')) {
      return replaceAll('~~', 'е');
    }
    return replaceAll('~~', 'й');
  }

  String getSearchString() {
    return toLowerCase().replaceAll(' ', '');
  }
}

extension Snull on String? {
  String get orEmpty => this ?? '';
}
