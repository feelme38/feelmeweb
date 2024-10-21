import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

import '../../main.dart';
import '../../provider/di/di_provider.dart';

class Dialogs {

  static Future<dynamic> showBaseDialog(
      BuildContext? fromContext,
      Widget content,
      { Function(dynamic)? dismissCallback }
  ) async {
    var context = fromContext ?? getContext();
    if (context != null) {
      var result = await showDialog(
          context: context,
          builder: (context) {
            return SizedBox(
                child: Center(
                    child: Container(
                        width: context.currentSize.width * 0.9,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(Dimen.size4))),
                        padding: const EdgeInsets.only(
                            left: Dimen.size24,
                            right: Dimen.size24,
                            top: Dimen.size24,
                            bottom: Dimen.size8),
                        child: content)));
          });
      dismissCallback?.call(null);
      return result;
    }
  }

  static BuildContext? getContext() => getIt<RouteGenerator>().navigatorKey.currentState?.context;
}
