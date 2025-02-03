import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/device_powers.dart';
import 'package:feelmeweb/data/repository/devices/devices_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class GetDeviceModelsUseCase
    extends UseCase<Result<List<DeviceModelsResponse>>> {
  final _repository = getIt<DevicesRepository>();

  @override
  Future<Result<List<DeviceModelsResponse>>> call() =>
      _repository.getDeviceModels();
}
