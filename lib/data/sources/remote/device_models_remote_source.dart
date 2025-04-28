import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class DeviceModelsRemoteSource {
  final NetworkProvider _networkProvider;

  DeviceModelsRemoteSource(this._networkProvider);

  Future<Result<List<DeviceModelResponse>>> getDeviceModels() async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.deviceModels);
      var result = (response.data as List)
          .map((e) => DeviceModelResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
