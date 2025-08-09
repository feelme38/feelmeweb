import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/add_device_body.dart';
import 'package:feelmeweb/data/repository/devices/devices_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class CreateDeviceUseCase extends UseCaseParam<Result<bool>, AddDeviceBody> {
  final _repository = getIt<DevicesRepository>();

  @override
  Future<Result<bool>> call(AddDeviceBody param) =>
      _repository.addDevice(param);
}
