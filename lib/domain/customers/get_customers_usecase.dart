import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/repository/customers/customers_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetCustomersUseCase
    extends UseCaseNameParam<Result<List<CustomerResponse>>, String?> {
  final _repository = getIt<CustomersRepository>();

  @override
  Future<Result<List<CustomerResponse>>> call({String? param}) {
    return _repository.getCustomers(regionId: param);
  }
}
