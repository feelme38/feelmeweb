import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/update_aroma_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart';
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
  Future<Result<bool>> updateAroma(UpdateAromaBody body) async {
    return await _aromasRemoteSource.updateAroma(body);
  }

  @override
  Future<Result<bool>> createAroma(CreateAromaBody body) =>
      _aromasRemoteSource.createAroma(body);

  @override
  Future<Result<void>> deleteAroma(String aromaId) =>
      _aromasRemoteSource.deleteAroma(aromaId);
}

abstract class AromasRepository {
  Future<Result<bool>> updateAroma(UpdateAromaBody body);
  Future<Result<bool>> createAroma(CreateAromaBody body);
  Future<Result<void>> deleteAroma(String aromaId);

  Future<Result<List<AromaResponse>>> getAromas();
}
