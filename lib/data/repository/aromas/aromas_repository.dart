import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart';
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/create_aroma_body.dart';

@Singleton(as: AromasRepository)
class AromasRepositoryImpl extends AromasRepository {
  final AromasRemoteSource _aromasRemoteSource;

  AromasRepositoryImpl(this._aromasRemoteSource);

  @override
  Future<Result<List<AromaResponse>>> getAromas() async {
    return await _aromasRemoteSource.getAromas();
  }

  @override
  Future<Result<bool>> createAroma(CreateAromaBody body) =>
      _aromasRemoteSource.createAroma(body);
}

abstract class AromasRepository {
  Future<Result<bool>> createAroma(CreateAromaBody body);

  Future<Result<List<AromaResponse>>> getAromas();
}
