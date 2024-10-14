import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';

import '../../core/enum/button_type.dart';
import '../theme/dimen.dart';
import '../theme/theme_colors.dart';

class BaseTextButton extends StatelessWidget {
  const BaseTextButton(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.type = ButtonType.normal,
      required this.enabled,
      this.contentAlign,
      this.textAlign,
      this.buttonColor,
      this.buttonSubColor,
      this.weight,
      this.fontSize,
      this.childOnStack,
      this.withMargin,
      this.needPadding = true,
      this.textColor})
      : super(key: key);

  final Function() onTap;
  final Widget? childOnStack;
  final String buttonText;
  final TextAlign? textAlign;
  final MainAxisAlignment? contentAlign;
  final Color? buttonColor;
  final Color? buttonSubColor;
  final ButtonType type;
  final FontWeight? weight;
  final double? fontSize;
  final bool? withMargin;
  final bool enabled;
  final Color? textColor;
  final bool needPadding;

  @override
  Widget build(BuildContext context) {
    return childOnStack != null
        ? Stack(children: [
            button(context),
            Positioned(
                top: Dimen.size12,
                bottom: Dimen.size12,
                right: Dimen.size12,
                child: childOnStack!)
          ])
        : button(context);
  }

  Widget button(BuildContext context) {
    return CupertinoButton(
        padding: const EdgeInsets.all(Dimen.size0),
        onPressed: enabled ? onTap : null,
        child: Container(
            margin: withMargin == true
                ? const EdgeInsets.symmetric(horizontal: Dimen.size8)
                : EdgeInsets.zero,
            height: Dimen.size48,
            padding: needPadding
                ? const EdgeInsets.symmetric(horizontal: Dimen.size12)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimen.size12)),
                border: type.isOutline
                    ? Border.all(
                        color: buttonColor ?? AppColor.primary,
                        width: Dimen.size1)
                    : null,
                gradient: buttonSubColor != null
                    ? LinearGradient(
                        colors: enabled
                            ? [
                                buttonSubColor!,
                                buttonColor ?? AppColor.darkBlue
                              ]
                            : [
                                AppColor.basicLightGrey,
                                AppColor.basicLightGrey
                              ])
                    : null,
                color: buttonSubColor == null
                    ? (type.isNormal
                        ? (enabled
                            ? (buttonColor ?? AppColor.primary)
                            : AppColor.lightIndicator)
                        : Colors.white)
                    : null),
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: contentAlign ?? MainAxisAlignment.center,
                children: [
                  Text(buttonText,
                      textAlign: textAlign,
                      style: context.themeData.textTheme.bodyLarge?.copyWith(
                          fontWeight: weight,
                          fontSize: fontSize,
                          color: enabled
                              ? (!type.isNormal
                                  ? AppColor.primary
                                  : textColor ?? Colors.white)
                              : Colors.black54))
                ])));
  }
}
