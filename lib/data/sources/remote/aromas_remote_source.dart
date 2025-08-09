import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/update_aroma_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/request/create_aroma_body.dart';

@singleton
class AromasRemoteSource {
  final NetworkProvider _networkProvider;

  AromasRemoteSource(this._networkProvider);

  Future<Result<List<AromaResponse>>> getAromas() async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.aromas);
      var result = (response.data as List)
          .map((e) => AromaResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> createAroma(CreateAromaBody body) async {
    try {
      await _networkProvider.dio.onWebPost(Urls.aroma, data: body.toJson());

      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result> deleteAroma(String? aromaId) async {
    try {
      await _networkProvider.dio.onDelete("${Urls.aroma}/$aromaId");
      return Success(null);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> updateAroma(UpdateAromaBody body) async {
    try {
      await _networkProvider.dio
          .onPut("${Urls.aroma}/${body.id}", data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
