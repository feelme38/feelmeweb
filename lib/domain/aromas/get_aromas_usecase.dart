
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/repository/aromas/aromas_repository.dart';
import 'package:feelmeweb/data/repository/users/users_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetAromasUseCase extends UseCase<Result<List<AromaResponse>>> {

  final _repository = getIt<AromasRepository>();

  @override
  Future<Result<List<AromaResponse>>> call() {
    return _repository.getAromas();
  }

}