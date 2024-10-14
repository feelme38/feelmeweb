import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseIcon extends StatelessWidget {
  const BaseIcon(this.asset, {this.color, this.size, Key? key})
      : super(key: key);

  final String asset;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
