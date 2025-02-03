import 'package:flutter/cupertino.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

class BaseSegmentedControl<T> extends StatelessWidget {
  const BaseSegmentedControl(this.selected, this.items,
      {this.onPressed, Key? key})
      : super(key: key);

  final T selected;
  final Map<T, String> items;
  final Function(T value)? onPressed;

  @override
  Widget build(BuildContext context) {
    final children = <T, Widget>{};
    for (final MapEntry<T, String> entry in items.entries) {
      children[entry.key] = renderItem(entry.value);
    }
    return SizedBox(
        width: double.infinity,
        child: CupertinoSlidingSegmentedControl<T>(
          backgroundColor: CupertinoColors.systemGrey6,
          groupValue: selected,
          onValueChanged: (value) {
            if (value != null) onPressed?.call(value);
          },
          children: children,
        ));
  }

  Widget renderItem(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        label,
        style: const TextStyle(
            color: CupertinoColors.black,
            fontSize: Dimen.size14,
            fontWeight: FontWeight.w500,
            letterSpacing: Dimen.size1 / 10),
      ),
    );
  }
}
