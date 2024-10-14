import 'package:flutter/material.dart';
import 'package:feelmeweb/presentation/buttons/base_text_icon_button.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

enum ButtonVariant {
  neutral,
  primary,
}

class BaseButton extends StatelessWidget {
  const BaseButton(this.text,
      {this.onPressed,
      this.enabled = true,
      this.variant = ButtonVariant.neutral,
      super.key});

  final String text;
  final dynamic Function()? onPressed;
  final bool enabled;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: BaseTextIconButton(
      text,
      onPressed ?? () {},
      enabled,
      contentColor: getContentColor(variant),
      fontSize: Dimen.size18,
      backgroundColor: getBackgroundColor(variant),
    ));
  }

  Color getBackgroundColor(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.neutral:
        return AppColor.basicLightGrey;
      case ButtonVariant.primary:
        return AppColor.primary;
    }
  }

  Color getContentColor(ButtonVariant variant) {
    switch (variant) {
      case ButtonVariant.neutral:
        return AppColor.grey;
      case ButtonVariant.primary:
        return Colors.white;
    }
  }
}
