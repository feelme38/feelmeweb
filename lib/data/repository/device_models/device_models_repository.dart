import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:feelmeweb/data/sources/remote/device_models_remote_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: DeviceModelsRepository)
class DeviceModelsRepositoryImpl extends DeviceModelsRepository {
  final DeviceModelsRemoteSource _deviceModelsRemoteSource;

  DeviceModelsRepositoryImpl(this._deviceModelsRemoteSource);

  @override
  Future<Result<List<DeviceModelResponse>>> getDeviceModels() async {
    return await _deviceModelsRemoteSource.getDeviceModels();
  }
}

abstract class DeviceModelsRepository {
  Future<Result<List<DeviceModelResponse>>> getDeviceModels();
}
