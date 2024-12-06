import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/presentation/modals/widgets/add_address_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/addresses_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/create_user_dialog.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

import '../../main.dart';
import '../../provider/di/di_provider.dart';

class Dialogs {
  static Future<void> showCreateUserDialog(
      BuildContext? fromContext, CreateUserCallback callback) async {
    final context = fromContext ?? getContext();
    if (context != null) {
      await showBaseDialog(
          context, CreateUserDialog(createUserCallback: callback),
          width: context.currentSize.width * 0.5);
    }
  }

  static Future<void> showAddressesDialog(
      BuildContext? fromContext,
      List<AddressDTO> addresses,
      List<RegionResponse> regions,
      AddCustomerCallback addCustomerCallback,
      String customerId) async {
    final context = fromContext ?? getContext();
    if (context != null) {
      await showBaseDialog(
          context,
          AddressesDialog(
            addresses: addresses,
            customerId: customerId,
            regions: regions,
            addCustomerCallback: addCustomerCallback,
            fromContext: context,
          ),
          width: context.currentSize.width * 0.5);
    }
  }

  static Future<dynamic> showBaseDialog(
      BuildContext? fromContext, Widget content,
      {Function(dynamic)? dismissCallback, double? width}) async {
    var context = fromContext ?? getContext();
    if (context != null) {
      var result = await showDialog(
          context: context,
          builder: (context) {
            return SizedBox(
                child: Center(
                    child: Container(
                        width: width ?? context.currentSize.width * 0.9,
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

  static BuildContext? getContext() =>
      getIt<RouteGenerator>().navigatorKey.currentState?.context;
}
