
import 'package:feelmeweb/core/result/result_of.dart';
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

}

abstract class DevicesRepository {
  Future<Result> deleteDevice(String deviceId);
}