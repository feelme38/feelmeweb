
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/data/sources/remote/aromas_remote_source.dart';
import 'package:feelmeweb/data/sources/remote/users_remote_source.dart';
import 'package:injectable/injectable.dart';

import '../../sources/remote/customers_remote_source.dart';

@Singleton(as: CustomersRepository)
class CustomersRepositoryImpl extends CustomersRepository {

  final CustomersRemoteSource _customersRemoteSource;

  CustomersRepositoryImpl(this._customersRemoteSource);

  @override
  Future<Result<List<CustomerResponse>>> getCustomers({String? regionId}) async {
    return await _customersRemoteSource.getCustomers(regionId: regionId);
  }

}

abstract class CustomersRepository {
  Future<Result<List<CustomerResponse>>> getCustomers({String? regionId});
}