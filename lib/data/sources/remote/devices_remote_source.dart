
import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';

@singleton
class DevicesRemoteSource {
  final NetworkProvider _networkProvider;

  DevicesRemoteSource(this._networkProvider);

  Future<Result<void>> deleteDevice(String deviceId) async {
    try {
      await _networkProvider.dio.onDelete(
          '${Urls.device}/$deviceId',
      );
      return EmptyResult();
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

}