import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/request/add_device_body.dart';
import '../../models/response/device_powers.dart';

@singleton
class DevicesRemoteSource {
  final NetworkProvider _networkProvider;

  DevicesRemoteSource(this._networkProvider);

  Future<Result<bool>> createDevice(AddDeviceBody body) async {
    try {
      await _networkProvider.dio.onWebPost(Urls.device, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<List<DevicePowersResponse>>> getDevicePowers() async {
    try {
      return Success(((await _networkProvider.dio.onGet(Urls.powers)).data
              as List<dynamic>)
          .map((e) => DevicePowersResponse.fromJson(e))
          .toList());
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<List<DeviceModelsResponse>>> getDeviceModels() async {
    try {
      return Success(((await _networkProvider.dio.onGet(Urls.deviceModels)).data
              as List<dynamic>)
          .map((e) => DeviceModelsResponse.fromJson(e))
          .toList());
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<void>> deleteDevice(String deviceId) async {
    try {
      await _networkProvider.dio.onDelete(
        '${Urls.device}/$deviceId',
      );
      return EmptyResult();
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
