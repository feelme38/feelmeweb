import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';

class ExpandableButton extends StatelessWidget {
  const ExpandableButton(
      {Key? key,
      required this.title,
      this.count = 0,
      this.icon,
      this.iconColor,
      this.route,
      this.args,
      this.parentContext,
      this.navigateCallback})
      : super(key: key);
  final Function()? navigateCallback;
  final String title;
  final int count;
  final dynamic args;
  final Widget? icon;
  final Color? iconColor;
  final String? route;
  final BuildContext? parentContext;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(Dimen.size16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimen.size12)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  offset: Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  offset: Offset(0, 0),
                  blurRadius: 2,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: route != null
                    ? () => context
                        .navigateTo(route!, args: args)
                        .then((value) => navigateCallback?.call())
                    : () {},
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 40,
                                height: 40,
                                padding: const EdgeInsets.all(Dimen.size8),
                                decoration: BoxDecoration(
                                    color: iconColor ?? AppColor.basicLightGrey,
                                    shape: BoxShape.circle),
                                child: icon),
                            Container(
                                constraints: const BoxConstraints(
                                  minHeight: Dimen.size24,
                                  maxHeight: Dimen.size24,
                                  minWidth: Dimen.size24,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimen.size6),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: AppColor.basicDarkGrey),
                                child: Center(
                                    child: Text('$count',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500))))
                          ]),
                      const SizedBox(height: Dimen.size8),
                      Text(title,
                          style: const TextStyle(
                              color: AppColor.grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5))
                    ]))));
  }
}
