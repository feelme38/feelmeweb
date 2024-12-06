import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/add_device_body.dart';
import 'package:feelmeweb/data/models/response/device_powers.dart';
import 'package:feelmeweb/data/sources/remote/devices_remote_source.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: DevicesRepository)
class DevicesRepositoryImpl extends DevicesRepository {
  final DevicesRemoteSource _devicesRemoteSource;

  DevicesRepositoryImpl(this._devicesRemoteSource);

  @override
  Future<Result> deleteDevice(String deviceId) async {
    return await _devicesRemoteSource.deleteDevice(deviceId);
  }

  @override
  Future<Result<bool>> addDevice(AddDeviceBody body) =>
      _devicesRemoteSource.createDevice(body);

  @override
  Future<Result<List<DeviceModelsResponse>>> getDeviceModels() =>
      _devicesRemoteSource.getDeviceModels();

  @override
  Future<Result<List<DevicePowersResponse>>> getDevicePowers() =>
      _devicesRemoteSource.getDevicePowers();
}

abstract class DevicesRepository {
  Future<Result> deleteDevice(String deviceId);

  Future<Result<List<DevicePowersResponse>>> getDevicePowers();

  Future<Result<List<DeviceModelsResponse>>> getDeviceModels();

  Future<Result<bool>> addDevice(AddDeviceBody body);
}
