import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/drawables.dart';

import 'package:feelmeweb/presentation/widgets/base_list_tile.dart';

class BaseExpandedWidget extends StatelessWidget {
  const BaseExpandedWidget(
      this.title, this.isExpanded, this.onTap, this.content,
      {this.noLinearContent,
      this.isLoading = false,
      this.isArrowHorizontal,
      this.subTitle,
      Key? key})
      : super(key: key);
  final String title;
  final bool isLoading;
  final String? subTitle;
  final bool isExpanded;
  final List<Widget> content;
  final List<Widget>? noLinearContent;
  final Function() onTap;
  final bool? isArrowHorizontal;

  @override
  Widget build(BuildContext context) {
    final hasNoLinearContent =
        noLinearContent != null && noLinearContent?.isNotEmpty == true;
    return CupertinoButton(
        onPressed: isLoading ? () {} : onTap,
        padding: EdgeInsets.zero,
        child: BaseListTile(
            borderRadius: Dimen.size20,
            horizontalPadding: 0,
            content:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(left: Dimen.size16, right: Dimen.size8),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(title,
                              style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black)),
                          const SizedBox(width: Dimen.size10),
                          if (subTitle != null)
                            Text(subTitle!,
                                style: context.themeData.textTheme.headlineMedium
                                    ?.copyWith(color: Colors.grey))
                        ]),
                        SvgPicture.asset(isExpanded
                            ? Drawables.arrowTop
                            : Drawables.arrowFwd)
                      ])),
              Visibility(
                  visible: isExpanded && content.isNotEmpty,
                  child: Container(
                      margin: const EdgeInsets.only(top: Dimen.size12),
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey[200])),
              Visibility(
                  visible: isExpanded && content.isNotEmpty,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimen.size16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: content),
                  )),
              Visibility(
                  visible: hasNoLinearContent && isExpanded,
                  maintainState: true,
                  child: SizedBox(
                      width: context.currentSize.width,
                      height: Dimen.size110,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: Dimen.size100,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: noLinearContent ?? [])))))
            ])));
  }
}
