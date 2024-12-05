import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart';
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../models/request/add_customer_address.dart';
import '../../models/response/checklist_info_response.dart';
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
}

abstract class CustomersRepository {

  Future<Result<List<CustomerResponse>>> getCustomers({String? regionId});
  Future<Result<bool>> addAddress(AddCustomerAddressBody body);

}
