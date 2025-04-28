import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/route_body.dart';
import 'package:feelmeweb/data/models/request/route_update_body.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'package:feelmeweb/domain/route/get_user_route_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/response/today_routes_response.dart';

@singleton
class RouteRemoteSource {
  final NetworkProvider _networkProvider;

  RouteRemoteSource(this._networkProvider);

  Future<Result<List<TodayRouteResponse>>> getRoutesToday() async {
    try {
      return Success(
          ((await _networkProvider.dio.onGet(Urls.routesToday)).data as List)
              .map((e) => TodayRouteResponse.fromJson(e))
              .toList());
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> createRoute({required RouteBody body}) async {
    try {
      print(body.toJson());
      await _networkProvider.dio.onWebPost(Urls.route, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> updateRoute({required RouteBody body}) async {
    try {
      await _networkProvider.dio.onPut(Urls.route, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<RouteResponse>> getUserRoute(GetUserRouteParam body) async {
    try {
      final response = await _networkProvider.dio
          .onGet(Urls.route, queryParams: {'userId': body.userId});
      return Success(RouteResponse.fromJson(response.data));
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> changeRouteStatus(
      {required RouteUpdateBody body}) async {
    try {
      await _networkProvider.dio.onPatch(Urls.routeStatus, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
