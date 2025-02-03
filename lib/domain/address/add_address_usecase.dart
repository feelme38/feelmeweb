import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/add_customer_address.dart';
import 'package:feelmeweb/data/repository/customers/customers_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class AddAddressUseCase
    extends UseCaseParam<Result<bool>, AddCustomerAddressBody> {
  final _repository = getIt<CustomersRepository>();

  @override
  Future<Result<bool>> call(AddCustomerAddressBody param) {
    return _repository.addAddress(param);
  }
}
