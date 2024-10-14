import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/presentation/widgets/base_icon.dart';
import 'package:feelmeweb/presentation/widgets/circled_text.dart';

import '../theme/dimen.dart';
import '../theme/drawables.dart';
import '../widgets/circle_icon.dart';

class RowTextIconButton extends StatelessWidget {
  final String asset;
  final String title;
  final Function() onPressed;
  final Color backgroundColor;
  final Color? iconColor;
  final double? titleSize;
  final String? subTitle;
  final bool decorated;
  final bool withBorder;
  final int? counter;
  final bool withPadding;

  const RowTextIconButton(
      this.title, this.asset, this.onPressed, this.backgroundColor,
      {this.subTitle,
      this.withBorder = false,
      this.counter,
      this.withPadding = false,
      this.decorated = false,
      this.iconColor,
      this.titleSize = Dimen.size16,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          padding: withPadding
              ? const EdgeInsets.only(
                  top: Dimen.size6,
                  bottom: Dimen.size6,
                  right: Dimen.size4,
                  left: Dimen.size8)
              : null,
          decoration: decorated
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimen.size12),
                  color: Colors.white,
                  boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.50,
                          blurRadius: Dimen.size5,
                          offset: const Offset(2, 2),
                          color: Colors.grey[300] ?? Colors.grey)
                    ])
              : null,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleIcon(
                  backgroundColor: backgroundColor,
                  asset: asset,
                  iconColor: iconColor,
                  withBorder: withBorder),
              const SizedBox(width: Dimen.size16),
              if (subTitle == null || subTitle?.isEmpty == true)
                Text(title,
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: titleSize)),
              if (subTitle != null && subTitle?.isNotEmpty == true)
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title,
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 15)),
                      const SizedBox(height: Dimen.size2),
                      Text(subTitle!,
                          style: GoogleFonts.notoSans(
                              color: AppColor.basicDarkGrey,
                              letterSpacing: Dimen.size1 / 10,
                              fontWeight: FontWeight.w500,
                              fontSize: Dimen.size14))
                    ])
            ]),
            trailing()
          ]),
        ));
  }

  Widget trailing() {
    if (counter == null) {
      return const BaseIcon(Drawables.arrowFwd, color: AppColor.basicDarkGrey);
    } else {
      return Row(children: [
        CircledText(counter.toString()),
        const SizedBox(width: Dimen.size4),
        const BaseIcon(Drawables.arrowFwd, color: AppColor.basicDarkGrey)
      ]);
    }
  }
}
