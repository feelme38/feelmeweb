import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/domain/users/get_users_usecase.dart';

import '../../presentation/alert/alert.dart';
import '../../presentation/base_vm/base_view_model.dart';

class UsersViewModel extends BaseViewModel {

  UsersViewModel() {
    loadUsers();
  }

  final _getUsersUseCase = GetUsersUseCase();
  List<UserResponse> _users = [];
  List<UserResponse> get users => _users;

  void loadUsers() async {
    loadingOn();
    (await executeUseCaseParam<List<UserResponse>, String?>(_getUsersUseCase, 'd73285b5-dd1a-43a4-8c04-4cb65f62af3a'))
        .doOnError((message, exception) {
      addAlert(Alert(message ?? '$exception', style: AlertStyle.danger));
    }).doOnSuccess((value) {
      _users = value;
      notifyListeners();
    });
    loadingOff();
  }
}