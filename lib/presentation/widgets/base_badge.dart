import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

enum BadgeType {
  neutral,
  accent,
  success,
  danger,
  warning,
}
extension BadgeValue on BadgeType {
  int get id {
    switch (this) {
      case BadgeType.neutral:
        return 0;
      default:
        return 2;
    }
  }
}

class BaseBadge extends StatelessWidget {
  const BaseBadge(this.label,
      {this.type = BadgeType.neutral, this.icon, Key? key})
      : super(key: key);

  final String label;
  final BadgeType type;
  final String? icon;

  Color getBgColorByType() {
    switch (type) {
      case BadgeType.accent:
        return const Color(0xFFE6F3FF);
      case BadgeType.success:
        return const Color(0xFFEAFFEA);
      case BadgeType.danger:
        return const Color(0xFFE6EBF1);
      case BadgeType.warning:
        return const Color(0xFFFFEFE0);
      default:
        return const Color(0xFFE6EBF1);
    }
  }

  Color getTextColorByType() {
    switch (type) {
      case BadgeType.accent:
        return const Color(0xFF2688EB);
      case BadgeType.success:
        return const Color(0xFF18B418);
      case BadgeType.danger:
        return const Color(0xFFFF3347);
      case BadgeType.warning:
        return const Color(0xFFFF7E00);
      default:
        return const Color(0xFF4F5E70);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = getBgColorByType();
    final textColor = getTextColorByType();
    return FittedBox(
      child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: Dimen.size4, horizontal: Dimen.size6),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(Dimen.size8)),
            color: bgColor,
          ),
          child: icon == null
              ? Text(label,
              style: const TextStyle(fontSize: 14, color: Colors.black))
              : Row(
            children: [
              icon != null
                  ? SvgPicture.asset(icon!,
                  height: Dimen.size16,
                  colorFilter:
                  ColorFilter.mode(textColor, BlendMode.srcIn))
                  : Container(),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      fontSize: 14,
                      color: textColor,
                      fontWeight: FontWeight.w500))
            ],
          )),
    );
  }
}
