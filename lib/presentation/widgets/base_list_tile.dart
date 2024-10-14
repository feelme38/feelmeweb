import 'package:flutter/material.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

class BaseListTile extends StatelessWidget {
  const BaseListTile(
      {required this.content,
      this.borderRadius = Dimen.size12,
      this.horizontalPadding = Dimen.size8,
      this.verticalPadding = Dimen.size12,
      Key? key})
      : super(key: key);
  final Widget content;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        margin: const EdgeInsets.symmetric(vertical: Dimen.size4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.50,
                  blurRadius: Dimen.size5,
                  offset: const Offset(2, 2),
                  color: Colors.grey[300] ?? Colors.grey)
            ]),
        child: content);
  }
}
