import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import '../theme/dimen.dart';

class TitleInfoColumnWidget extends StatelessWidget {
  const TitleInfoColumnWidget(this.title, this.text,
      {this.textColor,
      this.isAlignRight,
      this.hideTopPadding = false,
      this.rightWidget,
      this.containedText = false,
      this.onTap,
      Key? key})
      : super(key: key);

  final String title;
  final String text;
  final bool containedText;
  final Color? textColor;
  final bool? isAlignRight;
  final bool hideTopPadding;
  final Widget? rightWidget;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return text.isNotEmpty
        ? GestureDetector(
            onTap: onTap,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Column(
                          crossAxisAlignment: isAlignRight == true
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                        SizedBox(height: hideTopPadding ? 0 : Dimen.size12),
                        Text(title,
                            style: GoogleFonts.notoSans(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: Dimen.size4),
                        if (!containedText)
                          Text(text,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                        if (containedText)
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColor.basicLightGrey,
                                  borderRadius:
                                      BorderRadius.circular(Dimen.size8)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimen.size6,
                                  vertical: Dimen.size4),
                              child: Text(text,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)))
                      ])),
                  rightWidget ?? const SizedBox()
                ]))
        : const SizedBox();
  }
}
