import 'package:flutter/material.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({this.children, this.gap = Dimen.size16, super.key});

  final List<Widget>? children;
  final double gap;

  @override
  Widget build(BuildContext context) {
    final childList = children ?? [];
    return Row(
      children: childList
          .asMap()
          .entries
          .map(
            (entry) {
              int idx = entry.key;
              Widget element = entry.value;

              return [
                element,
                SizedBox(width: (idx + 1) == childList.length ? 0 : gap)
              ];
            },
          )
          .expand((i) => i)
          .toList(),
    );
  }
}
