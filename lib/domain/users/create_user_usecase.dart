import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/data/models/request/create_user_body.dart';
import 'package:feelmeweb/data/repository/customers/customers_repository.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';

class CreateUserUseCase extends UseCaseParam<Result<bool>, CreateUserBody> {
  final _repository = getIt<CustomersRepository>();

  @override
  Future<Result<bool>> call(CreateUserBody param) =>
      _repository.createCustomer(param);
}
