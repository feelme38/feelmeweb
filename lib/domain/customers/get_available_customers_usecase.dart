import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/response/customer_response.dart';
import 'package:feelmeweb/data/repository/customers/customers_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';

import '../../provider/di/di_provider.dart';

class GetAvailableCustomersParam {
  final String userId;
  final String regionId;

  GetAvailableCustomersParam(this.userId, this.regionId);
}

class GetAvailableCustomersUseCase extends UseCaseParam<
    Result<List<CustomerResponse>>, GetAvailableCustomersParam> {
  final _repository = getIt<CustomersRepository>();

  @override
  Future<Result<List<CustomerResponse>>> call(
      GetAvailableCustomersParam param) {
    return _repository.getAvailableCustomers(param);
  }
}
