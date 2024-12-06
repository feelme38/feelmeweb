import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/request/add_customer_address.dart';

@singleton
class CustomersRemoteSource {
  final NetworkProvider _networkProvider;

  CustomersRemoteSource(this._networkProvider);

  Future<Result<List<CustomerResponse>>> getCustomers(
      {String? regionId}) async {
    try {
      final response = await _networkProvider.dio.onGet(Urls.customers,
          queryParams: regionId != null ? {"regionId": regionId} : null);
      var result = (response.data as List)
          .map((e) => CustomerResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> createCustomer(CreateUserBody body) async {
    try {
      await _networkProvider.dio.onWebPost(Urls.customer, data: body.toJson());

      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> addCustomerAddress(AddCustomerAddressBody body) async {
    try {
      await _networkProvider.dio
          .onWebPost(Urls.customerAddress, data: body.toJson());
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
// Future<Result> deleteAroma(String? aromaId) async {
//   try {
//     await _networkProvider.dio.onGet(
//         Urls.aromas,
//         queryParams: {
//           "aromaId": aromaId
//         }
//     );
//     return Success(null);
//   } on DioException catch (e) {
//     return Failure(exception: e, message: e.message);
//   } on ConnectionException catch (e) {
//     return Failure(exception: e, message: e.message);
//   }
// }
}
