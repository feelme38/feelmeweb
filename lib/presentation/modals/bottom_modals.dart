import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';
import 'package:feelmeweb/presentation/widgets/sheet_top_slider.dart';
import '../navigation/route_generation.dart';

class BottomModals {

  static Future showModal(Widget child,
      {bool cancelable = true, bool withPad = false}) async {
    final context = getContext();
    if (context != null) {
      return showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          isDismissible: cancelable,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimen.size16),
                  topLeft: Radius.circular(Dimen.size16))),
          builder: (context) {
            return Padding(
                padding: withPad
                    ? EdgeInsets.only(bottom: context.insetsBottom ?? 0)
                    : EdgeInsets.zero,
                child: Wrap(children: [
                  Container(
                      padding: const EdgeInsets.all(Dimen.size20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimen.size16),
                              topLeft: Radius.circular(Dimen.size16))),
                      child: Column(children: [const SheetTopSlider(), child]))
                ]));
          });
    }
  }

  static BuildContext? getContext() => getIt<RouteGenerator>().navigatorKey.currentState?.context;
}
