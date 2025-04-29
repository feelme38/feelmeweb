import 'package:dio/dio.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/models/response/active_customer_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:injectable/injectable.dart';

import '../../../provider/network/network_provider.dart';
import '../../../provider/network/urls.dart';
import '../../models/request/add_customer_address.dart';
import '../../models/request/update_customer_body.dart';

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

  Future<Result<List<ActiveCustomerResponse>>> getActiveCustomers(
      String userId) async {
    try {
      final response = await _networkProvider.dio
          .onGet(Urls.customersActive, queryParams: {"userId": userId});
      var result = (response.data as List)
          .map((e) => ActiveCustomerResponse.fromJson(e))
          .toList();
      return Success(result);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> createCustomer(CreateCustomerBody body) async {
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

  Future<Result<bool>> updateCustomer(UpdateCustomerBody body) async {
    try {
      await _networkProvider.dio.onPatch(
        Urls.customer,
        data: body.toJson(),
      );
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }

  Future<Result<bool>> deleteCustomer(String id) async {
    try {
      await _networkProvider.dio.onDelete('${Urls.customer}/$id');
      return Success(true);
    } on DioException catch (e) {
      return Failure(exception: e, message: e.message);
    } on ConnectionException catch (e) {
      return Failure(exception: e, message: e.message);
    }
  }
}
