import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/devices/devices_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import '../../provider/di/di_provider.dart';

class DeleteDeviceUseCase extends UseCaseParam<Result<void>, String> {

  final _repository = getIt<DevicesRepository>();

  @override
  Future<Result<void>> call(String param) {
    return _repository.deleteDevice(param);
  }

}