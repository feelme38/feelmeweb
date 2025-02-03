import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/core/enum/button_type.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

class BaseDialogWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? firstButtonName;
  final String? secondButtonName;
  final Function()? firstCallback;
  final Function()? secondCallback;
  final MainAxisAlignment? mainAxisAlignmentTitle;
  final CrossAxisAlignment? crossAxisAlignmentSubtitle;

  const BaseDialogWidget(
      {this.subTitle,
      this.title,
      this.firstButtonName,
      this.firstCallback,
      this.crossAxisAlignmentSubtitle,
      this.mainAxisAlignmentTitle,
      this.secondButtonName,
      this.secondCallback,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      if (title != null)
        Row(children: [Expanded(child: Text(title!, style: titleStyle))]),
      if (subTitle != null)
        Column(
            crossAxisAlignment:
                crossAxisAlignmentSubtitle ?? CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Dimen.size8),
              Row(children: [
                Expanded(child: Text(subTitle!, style: subTitleStyle))
              ])
            ]),
      const SizedBox(width: Dimen.size12),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        if (firstButtonName != null)
          BaseTextButton(
              buttonText: firstButtonName!.toUpperCase(),
              onTap: () {
                if (firstCallback != null) {
                  firstCallback!();
                } else {
                  context.navigateUp(arg: false);
                }
              },
              fontSize: 16,
              type: ButtonType.text,
              enabled: true),
        if (secondButtonName != null)
          Row(children: [
            const SizedBox(width: Dimen.size8),
            BaseTextButton(
                buttonText: secondButtonName!.toUpperCase(),
                onTap: () {
                  if (secondCallback != null) {
                    secondCallback!();
                  } else {
                    context.navigateUp(arg: true);
                  }
                },
                fontSize: 16,
                type: ButtonType.text,
                enabled: true)
          ])
      ])
    ]);
  }

  TextStyle get titleStyle => GoogleFonts.notoSans(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      letterSpacing: 0.5,
      decoration: TextDecoration.none);

  TextStyle get subTitleStyle => GoogleFonts.notoSans(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black54,
      letterSpacing: 0.15,
      decoration: TextDecoration.none);
}
