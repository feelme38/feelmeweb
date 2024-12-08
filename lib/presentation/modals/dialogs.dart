import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/device_powers.dart';
import 'package:feelmeweb/data/models/response/region_response.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/presentation/modals/widgets/add_address_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/add_device_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/addresses_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/create_aroma_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/create_customer_dialog.dart';
import 'package:feelmeweb/presentation/modals/widgets/create_user_dialog.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/build_context_ext.dart';
import 'package:feelmeweb/presentation/theme/dimen.dart';

import '../../main.dart';
import '../../provider/di/di_provider.dart';

class Dialogs {
  static Future<void> createDeviceDialog(
      BuildContext? fromContext,
      List<DevicePowersResponse> powers,
      List<DeviceModelsResponse> models,
      List<AddressDTO> addresses,
      AddDeviceCallback addDeviceCallback) async {
    final context = fromContext ?? getContext();
    if (context != null) {
      await showBaseDialog(
          fromContext,
          AddDeviceDialog(
              models: models,
              powers: powers,
              callback: addDeviceCallback,
              addresses: addresses),
          width: context.currentSize.width * 0.4);
    }
  }

  static Future<void> showCreateUserDialog(
      BuildContext? fromContext, CreateUserCallback createUserCallback) async {
    final context = fromContext ?? getContext();
    if (context != null) {
      await showBaseDialog(
          context,
          CreateUserDialog(
              roles: getIt<UsersRepository>().roles,
              createUserCallback: createUserCallback),
          width: context.currentSize.width * 0.4);
    }
  }

  static Future<void> createAromaDialog(
      BuildContext? fromContext, CreateAromaCallback callback) async {
    final context = fromContext ?? getContext();
    if (context != null) {
      await showBaseDialog(context, CreateAromaDialog(callback: callback),
          width: context.currentSize.width * 0.4);
    }
  }

  static Future<void> showCreateCustomerDialog(
      BuildContext? fromContext, CreateCustomerCallback callback) async {
    final context = fromContext ?? getContext();
    if (context != null) {
      await showBaseDialog(
          context, CreateCustomerDialog(createUserCallback: callback),
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
                            left: Dimen.size16,
                            right: Dimen.size16,
                            top: Dimen.size16,
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
