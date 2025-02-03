import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/add_customer_address.dart';
import '../../sources/remote/customers_remote_source.dart';

@Singleton(as: CustomersRepository)
class CustomersRepositoryImpl extends CustomersRepository {
  final CustomersRemoteSource _customersRemoteSource;

  CustomersRepositoryImpl(this._customersRemoteSource);

  @override
  Future<Result<List<CustomerResponse>>> getCustomers({String? regionId}) {
    return _customersRemoteSource.getCustomers(regionId: regionId);
  }

  @override
  Future<Result<bool>> addAddress(AddCustomerAddressBody body) {
    return _customersRemoteSource.addCustomerAddress(body);
  }

  @override
  Future<Result<bool>> createCustomer(CreateCustomerBody body) {
    return _customersRemoteSource.createCustomer(body);
  }
}

abstract class CustomersRepository {
  Future<Result<List<CustomerResponse>>> getCustomers({String? regionId});

  Future<Result<bool>> createCustomer(CreateCustomerBody body);

  Future<Result<bool>> addAddress(AddCustomerAddressBody body);
}
