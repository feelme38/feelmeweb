import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_device_model_body.dart';
import 'package:feelmeweb/data/repository/devices/devices_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class CreateDeviceModelUseCase
    extends UseCaseParam<Result<bool>, CreateDeviceModelBody> {
  final _repository = getIt<DevicesRepository>();

  @override
  Future<Result<bool>> call(CreateDeviceModelBody param) =>
      _repository.createDeviceModel(param);
}
