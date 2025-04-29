import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_device_model_body.dart';
import 'package:feelmeweb/data/models/request/update_device_model_body.dart';
import 'package:feelmeweb/data/models/response/device_models.dart';
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

  Future<Result<bool>> createDeviceModel(CreateDeviceModelBody body) async {
    try {
      await _networkProvider.dio
          .onWebPost(Urls.deviceModels, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> updateDeviceModel(UpdateDeviceModelBody body) async {
    try {
      await _networkProvider.dio
          .onPut("${Urls.deviceModels}/${body.id}", data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> deleteDeviceModel(String modelId) async {
    try {
      await _networkProvider.dio.onDelete("${Urls.deviceModels}/$modelId");
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
      final response = await _networkProvider.dio.onGet(Urls.deviceModels);
      var result = (response.data as List)
          .map((e) => DeviceModelsResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> deleteDevice(String deviceId) async {
    try {
      await _networkProvider.dio.onDelete(
        '${Urls.device}/$deviceId',
      );
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
