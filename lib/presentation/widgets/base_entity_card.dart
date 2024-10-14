import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/drawables.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class BaseEntityCard extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Map<String, String> textItems;
  final Map<String, Widget> formItems;
  final bool isSyncProblem;
  final Widget? header;
  final Widget? child;
  final Widget? footer;

  const BaseEntityCard(this.title,
      {this.textItems = const {},
      this.formItems = const {},
      this.onPressed,
      this.isSyncProblem = false,
      this.header,
      this.child,
      this.footer,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textKeys = textItems.keys.toList();
    final formKeys = formItems.keys.toList();

    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimen.size12)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 16,
                      offset: Offset.zero),
                  BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: Offset.zero)
                ],
                border: Border.all(width: 1, color: AppColor.basicLightGrey)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: Dimen.size12,
                      left: Dimen.size12,
                      right: Dimen.size12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Text(title,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: Dimen.size16,
                                          letterSpacing: Dimen.size1 / 2))),
                              isSyncProblem
                                  ? SvgPicture.asset(Drawables.syncProblem)
                                  : const SizedBox()
                            ]),
                        header == null
                            ? const SizedBox(height: Dimen.size8)
                            : Container(
                                padding: const EdgeInsets.only(
                                    top: Dimen.size8, bottom: Dimen.size12),
                                child: header)
                      ])),
              const Divider(
                  height: 1, thickness: 1, color: AppColor.taskBackground),
              Padding(
                  padding: const EdgeInsets.only(
                      left: Dimen.size12,
                      right: Dimen.size12,
                      bottom: Dimen.size12),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        child != null
                            ? const SizedBox(height: Dimen.size12)
                            : const SizedBox(),
                        child ?? const SizedBox(),
                        ...textItems.entries
                            .map((entry) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height:
                                              textKeys.indexOf(entry.key) == 0
                                                  ? Dimen.size12
                                                  : Dimen.size8),
                                      Text(entry.key,
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  134, 151, 171, 255 * 0.87),
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dimen.size14,
                                              letterSpacing: 0.1,
                                              height: 1.4)),
                                      Text(entry.value,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: Dimen.size14,
                                              letterSpacing: 0.1,
                                              height: 1.4))
                                    ]))
                            .toList(),
                        ...formItems.entries
                            .map((entry) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          height:
                                              formKeys.indexOf(entry.key) == 0
                                                  ? Dimen.size12
                                                  : Dimen.size20),
                                      RichText(
                                          text: TextSpan(
                                              text: entry.key.endsWith('*')
                                                  ? entry.key.substring(
                                                      0, entry.key.length - 1)
                                                  : entry.key,
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(134,
                                                      151, 171, 255 * 0.87),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: Dimen.size14,
                                                  letterSpacing:
                                                      Dimen.size1 / 10,
                                                  height: 1.4),
                                              children: entry.key.endsWith('*')
                                                  ? [
                                                      const TextSpan(
                                                          text: '*',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red))
                                                    ]
                                                  : [])),
                                      const SizedBox(height: Dimen.size8),
                                      entry.value
                                    ]))
                            .toList()
                      ])),
              const Divider(height: 0, color: AppColor.taskBackground),
              if (footer != null)
                Container(
                    padding: const EdgeInsets.all(Dimen.size12), child: footer)
            ])));
  }
}
