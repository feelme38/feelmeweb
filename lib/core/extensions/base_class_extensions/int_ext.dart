
extension IntNValue on int? {
  int get orZero => this ?? 0;
}