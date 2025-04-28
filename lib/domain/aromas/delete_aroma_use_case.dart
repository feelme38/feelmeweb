import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class DeleteAromaUseCase extends UseCaseParam<Result<void>, String> {
  final _repository = getIt<AromasRepository>();

  @override
  Future<Result<void>> call(String param) => _repository.deleteAroma(param);
}
