import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

class CircleIcon extends StatelessWidget {
  final IconData? icon;
  final Size? size;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;
  final String? asset;

  final bool withBorder;

  const CircleIcon(
      {this.icon,
      this.size,
      this.iconSize,
      this.asset,
      this.backgroundColor,
      this.iconColor,
      this.withBorder = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size?.height ?? Dimen.size36,
        width: size?.width ?? Dimen.size36,
        decoration: BoxDecoration(
            border: withBorder ? Border.all(color: Colors.grey[300]!) : null,
            color: backgroundColor ?? Colors.grey[300],
            shape: BoxShape.circle),
        child: Center(
            child: asset != null
                ? (isSvg == true
                    ? SvgPicture.asset(asset!,
                        height: size?.height ?? Dimen.size24,
                        width: size?.width ?? Dimen.size24,
                        color: iconColor)
                    : Image.asset(asset!,
                        height: size?.height ?? Dimen.size24,
                        width: size?.width ?? Dimen.size24,
                        color: iconColor ?? Colors.white))
                : Icon(
                    icon,
                    color: iconColor ?? Colors.white,
                    size: iconSize ?? Dimen.size24,
                  )));
  }

  bool get isSvg => asset?.endsWith('.svg') == true;
}
