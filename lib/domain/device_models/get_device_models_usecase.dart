import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/device_model_response.dart';
import 'package:feelmeweb/data/repository/device_models/device_models_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAromasUseCase extends UseCase<Result<List<DeviceModelResponse>>> {
  final _repository = getIt<DeviceModelsRepository>();

  @override
  Future<Result<List<DeviceModelResponse>>> call() {
    return _repository.getDeviceModels();
  }
}
