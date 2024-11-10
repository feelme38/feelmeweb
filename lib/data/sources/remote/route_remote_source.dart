
import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/task_types_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class RouteRemoteSource {
  final NetworkProvider _networkProvider;

  RouteRemoteSource(this._networkProvider);

  Future<Result<bool>> createRoute({required RouteBody body}) async {
    try {
      await _networkProvider.dio.onWebPost(
          Urls.createRoute,
          data: body.toJson()
      );
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}