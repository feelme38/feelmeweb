import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

import '../theme/dimen.dart';

class CircledText extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;

  const CircledText(this.text,
      {this.bgColor = AppColor.basicDarkGrey,
      this.textColor = Colors.white,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(Dimen.size7),
        decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
        child: Center(
            child: Text(text,
                style: GoogleFonts.notoSans(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600))));
  }
}
