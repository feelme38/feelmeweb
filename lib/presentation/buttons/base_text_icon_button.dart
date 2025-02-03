import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/dimen.dart';
import '../theme/theme_colors.dart';

class BaseTextIconButton extends StatelessWidget {
  const BaseTextIconButton(this.title, this.onTap, this.enabled,
      {this.width,
      this.subtitle,
      this.subtitleColor,
      this.contentColor,
      this.icon,
      this.resource,
      this.orientationVertical = false,
      this.secondaryBackColor,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500,
      this.onlyMarginStart = false,
      this.onlyMarginEnd = false,
      this.needBottomPadding = false,
      this.withMargin,
      this.iconSize = 24,
      this.isIconFirst = false,
      this.backgroundColor,
      Key? key})
      : super(key: key);
  final IconData? icon;
  final double fontSize;
  final FontWeight fontWeight;
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final bool? withMargin;
  final bool onlyMarginStart;
  final bool onlyMarginEnd;
  final Color? backgroundColor;
  final Color? secondaryBackColor;
  final double iconSize;
  final bool needBottomPadding;
  final Color? contentColor;
  final bool orientationVertical;
  final double? width;
  final Function() onTap;
  final String? resource;
  final bool enabled;
  final bool isIconFirst;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: const EdgeInsets.all(Dimen.size0),
        onPressed: enabled ? onTap : () {},
        child: Container(
            margin: withMargin == true
                ? const EdgeInsets.symmetric(horizontal: Dimen.size8)
                : EdgeInsets.zero,
            width: width,
            padding: const EdgeInsets.only(
                top: Dimen.size12,
                bottom: Dimen.size12,
                left: Dimen.size8,
                right: Dimen.size10),
            decoration: BoxDecoration(
                color: secondaryBackColor == null
                    ? enabled
                        ? backgroundColor ?? AppColor.lightIndicator
                        : AppColor.lightIndicator
                    : null,
                gradient: secondaryBackColor != null
                    ? LinearGradient(
                        colors: enabled
                            ? [secondaryBackColor!, backgroundColor!]
                            : [AppColor.lightIndicator])
                    : null,
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimen.size12))),
            child: orientationVertical
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        resource != null
                            ? SvgPicture.asset(resource!,
                                color:
                                    enabled ? contentColor : AppColor.textGrey)
                            : Icon(icon,
                                color: enabled
                                    ? contentColor ?? AppColor.textGrey
                                    : AppColor.textGrey,
                                size: iconSize),
                        const SizedBox(height: Dimen.size16),
                        Text(title,
                            style: GoogleFonts.notoSans(
                                fontSize: fontSize,
                                color:
                                    enabled ? contentColor : AppColor.textGrey,
                                fontWeight: fontWeight))
                      ])
                : isIconFirst
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            resource != null
                                ? SvgPicture.asset(resource!,
                                    color: enabled
                                        ? contentColor
                                        : AppColor.textGrey,
                                    height: Dimen.size24,
                                    width: Dimen.size24)
                                : icon != null
                                    ? Icon(icon,
                                        color:
                                            contentColor ?? AppColor.textGrey,
                                        size: iconSize)
                                    : const SizedBox(),
                            if (resource != null || icon != null)
                              const SizedBox(width: Dimen.size12),
                            Text(title,
                                maxLines: 1,
                                style: GoogleFonts.notoSans(
                                    fontSize: fontSize,
                                    color: enabled
                                        ? contentColor
                                        : AppColor.textGrey,
                                    fontWeight: fontWeight))
                          ])
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Padding(
                                padding: needBottomPadding
                                    ? const EdgeInsets.only(bottom: Dimen.size6)
                                    : EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    Text(title,
                                        maxLines: 1,
                                        style: GoogleFonts.lato(
                                            fontSize: fontSize,
                                            color: enabled
                                                ? contentColor
                                                : AppColor.textGrey,
                                            fontWeight: fontWeight)),
                                    subtitle != null ? Text(subtitle!,
                                        maxLines: 1,
                                        style: GoogleFonts.lato(
                                            fontSize: 16,
                                            color: enabled
                                                ? subtitleColor
                                                : AppColor.textGrey,
                                            fontWeight: fontWeight))
                                        : const SizedBox()
                                  ],
                                )),
                            if (resource != null || icon != null)
                              const SizedBox(width: Dimen.size8),
                            resource != null
                                ? SvgPicture.asset(resource!,
                                    color: enabled
                                        ? contentColor
                                        : AppColor.textGrey,
                                    height: Dimen.size24,
                                    width: Dimen.size24)
                                : icon != null
                                    ? Icon(icon,
                                        color:
                                            contentColor ?? AppColor.textGrey,
                                        size: iconSize)
                                    : const SizedBox()
                          ])));
  }
}
