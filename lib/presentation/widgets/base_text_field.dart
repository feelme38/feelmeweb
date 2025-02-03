import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';

import '../theme/dimen.dart';
import '../theme/theme_colors.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField(
      {super.key,
      required this.controller,
      this.onTextChange,
      this.onSubmit,
      this.formatters,
      this.helperText,
      this.helperTopIndent = Dimen.size6,
      this.fontWeight = FontWeight.w400,
      this.type,
      this.hasFocus,
      this.hasError = false,
      this.obscure,
      this.onObscureToggle,
      this.maxLength,
      this.isPhone,
      this.hint,
      this.validate,
      this.height,
      this.background = Colors.white,
      this.borderColor,
      this.textColor,
      this.width,
      this.node,
      this.maxLines,
      this.expands,
      this.suffix,
      this.minLines,
      this.alignLabelWithHint,
      this.danger,
      this.flexible = false,
      this.dangerText,
      this.scrollPadding});
  final FocusNode? node;
  final bool flexible;
  final TextEditingController controller;
  final Function(String)? onTextChange;
  final Function(String)? onSubmit;
  final String? hint;
  final Widget? suffix;
  final TextInputType? type;
  final bool? obscure;
  final Function? onObscureToggle;
  final String? helperText;
  final double helperTopIndent;
  final FontWeight? fontWeight;
  final int? maxLength;
  final int? maxLines;
  final bool? isPhone;
  final int? minLines;
  final double? height;
  final double? width;
  final Color background;
  final Color? borderColor;
  final Color? textColor;
  final bool? expands;
  final bool? hasFocus;
  final bool? hasError;
  final bool? alignLabelWithHint;
  final bool? danger;
  final String? dangerText;
  final EdgeInsets? scrollPadding;
  final List<TextInputFormatter>? formatters;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      isPhone == true
          ? Container(
              height: 56,
              padding: EdgeInsets.only(
                  bottom: helperText != null ? Dimen.size4 : Dimen.size0,
                  left: Dimen.size12,
                  right: Dimen.size12,
                  top: helperText != null ? helperTopIndent : Dimen.size2),
              decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.all(Radius.circular(Dimen.size12)),
                  border:
                      Border.all(width: Dimen.size0_8, color: _borderColor)),
              child: TextFormField(
                  focusNode: node,
                  minLines: minLines ?? 1,
                  maxLines: minLines,
                  controller: controller,
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: "  ### ### ####", initialText: controller.text),
                  ],
                  onChanged: onTextChange,
                  style: context.themeData.textTheme.headlineMedium,
                  decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: _textColor, fontSize: Dimen.size18),
                      hintStyle:
                          TextStyle(color: _textColor, fontSize: Dimen.size18),
                      contentPadding: EdgeInsets.only(
                          bottom:
                              helperText != null ? Dimen.size4 : Dimen.size16,
                          top: helperText != null ? Dimen.size2 : Dimen.size0),
                      hintText: '             ',
                      labelText: helperText ?? ' ',
                      prefix: Text('+7',
                          style: context.themeData.textTheme.headlineMedium),
                      border: InputBorder.none)))
          : flexible
              ? flexibleField(context)
              : Container(
                  padding: EdgeInsets.only(
                      left: Dimen.size12,
                      right: Dimen.size12,
                      bottom: 0,
                      top: helperText != null ? helperTopIndent : Dimen.size2),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(Dimen.size12)),
                      border: Border.all(
                          width: Dimen.size0_8, color: _borderColor)),
                  height: height ?? 56,
                  child: Row(children: [
                    Expanded(
                        child: TextFormField(
                            focusNode: node,
                            onFieldSubmitted: onSubmit,
                            expands: expands ?? false,
                            validator: validate,
                            scrollPadding: scrollPadding ?? EdgeInsets.zero,
                            controller: controller,
                            textAlignVertical: TextAlignVertical.top,
                            maxLines: obscure == true ? 1 : maxLines,
                            obscureText: obscure ?? false,
                            maxLength: maxLength,
                            inputFormatters: formatters ?? [],
                            keyboardType: type,
                            onChanged: onTextChange,
                            style: context.themeData.textTheme.headlineMedium
                                ?.copyWith(
                                    fontWeight: fontWeight,
                                    color: Colors.black),
                            decoration: InputDecoration(
                                label: Text(helperText ?? ''),
                                labelStyle: TextStyle(
                                    color: _textColor, fontSize: Dimen.size18),
                                alignLabelWithHint: alignLabelWithHint,
                                contentPadding: EdgeInsets.only(
                                    bottom: helperText != null
                                        ? Dimen.size5_5
                                        : Dimen.size18,
                                    top: helperText != null
                                        ? Dimen.size2
                                        : Dimen.size0),
                                hintText: hint,
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none))),
                    if (onObscureToggle != null)
                      CupertinoButton(
                          padding: const EdgeInsets.only(top: Dimen.size5_5),
                          onPressed: () => onObscureToggle!(),
                          child: Icon(obscure != true
                              ? Icons.visibility_off
                              : Icons.visibility,
                              color: AppColor.basicDarkGrey,
                              size: 24)),
                    if (suffix != null) suffix!
                  ])),
      if (danger == true && dangerText != null)
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                top: Dimen.size4, left: Dimen.size12 + Dimen.size0_8),
            child: Text(dangerText ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(color: _textColor, fontSize: Dimen.size18)))
    ]);
  }

  Widget flexibleField(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: Dimen.size12,
            right: Dimen.size12,
            top: helperText != null ? helperTopIndent : Dimen.size2),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(Dimen.size12)),
            border: Border.all(width: Dimen.size0_8, color: _borderColor)),
        child: TextFormField(
            focusNode: node,
            onFieldSubmitted: onSubmit,
            expands: expands ?? false,
            validator: validate,
            controller: controller,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            obscureText: obscure ?? false,
            maxLength: maxLength,
            inputFormatters: formatters ?? [],
            keyboardType: type,
            onChanged: onTextChange,
            style: context.themeData.textTheme.headlineMedium
                ?.copyWith(fontWeight: fontWeight, fontSize: Dimen.size18),
            decoration: InputDecoration(
                label: Text(helperText ?? ''),
                labelStyle:
                    TextStyle(color: _textColor, fontSize: Dimen.size18),
                alignLabelWithHint: alignLabelWithHint,
                contentPadding: EdgeInsets.only(
                    bottom: helperText != null ? Dimen.size8 : Dimen.size18,
                    top: helperText != null ? Dimen.size2 : Dimen.size0),
                hintText: hint,
                hintStyle: const TextStyle(fontSize: Dimen.size18),
                border: InputBorder.none)));
  }

  get _accentColor {
    if (danger == true) {
      return AppColor.reject;
    } else if (hasFocus == true) {
      return AppColor.primary;
    } else {
      return null;
    }
  }

  get _textColor => _accentColor ?? textColor ?? Colors.black;

  get _borderColor {
    if (hasError == true) return AppColor.reject;
    return _accentColor ?? borderColor ?? Colors.black;
  }
}
