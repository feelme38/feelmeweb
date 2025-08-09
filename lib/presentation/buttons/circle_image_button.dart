import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class CircleImageButton extends StatelessWidget {
  final String asset;
  final IconData? iconData;
  final Function() onPressed;
  final Color backgroundColor;
  final Color? subColor;
  final Color contentColor;
  final bool hasBorder;
  final Color borderColor;
  final double size;
  final bool isLoading;

  const CircleImageButton(this.onPressed, this.size,
      {this.iconData,
      this.asset = '',
      this.backgroundColor = AppColor.primary,
      this.subColor,
      this.isLoading = false,
      this.contentColor = Colors.white,
      this.hasBorder = false,
      this.borderColor = Colors.white,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
                color: subColor != null ? null : backgroundColor,
                gradient: subColor == null
                    ? null
                    : LinearGradient(colors: [backgroundColor, subColor!]),
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimen.size100)),
                border: hasBorder ? Border.all(color: borderColor) : null),
            child: Stack(children: [
              Center(
                  child: iconData != null
                      ? Icon(iconData, color: contentColor)
                      : isSvg
                          ? SvgPicture.asset(asset, color: contentColor)
                          : Image.asset(asset, color: contentColor)),
              isLoading
                  ? Center(
                      child: SizedBox(
                          height: size - 2,
                          width: size - 2,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          )))
                  : const SizedBox()
            ])));
  }

  bool get isSvg => asset.endsWith('.svg');
}
