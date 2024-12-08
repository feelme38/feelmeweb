import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_aroma_body.dart';
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class CreateAromaUseCase extends UseCaseParam<Result<bool>, CreateAromaBody> {
  final _repository = getIt<AromasRepository>();

  @override
  Future<Result<bool>> call(CreateAromaBody param) =>
      _repository.createAroma(param);
}
