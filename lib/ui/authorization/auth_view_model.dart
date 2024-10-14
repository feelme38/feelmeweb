import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:feelmeweb/core/enum/auth_result.dart';
import 'package:feelmeweb/core/extensions/base_class_extensions/string_ext.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';

import '../../presentation/base_vm/base_view_model.dart';

class AuthViewModel extends BaseViewModel {

  final TextEditingController loginController = TextEditingController()
    ..text = kDebugMode ? '79009001022' : '';
  final TextEditingController passwordController = TextEditingController()
    ..text = kDebugMode ? '123123123' : '';

  String versionName = '';

  bool get isLoginEnabled =>
      loginController.text.isValid && passwordController.text.isValid;
  late final FocusNode loginNode = FocusNode()..addListener(nodeLoginListener);
  late final FocusNode passwordNode = FocusNode()
    ..addListener(nodePassListener);
  // final _authUseCase = AuthUseCase();

  bool loginHasFocus = true;
  bool passHasFocus = false;
  bool authFailed = false;
  bool obscurePassword = true;

  void textControllerChange() {
    notifyListeners();
  }

  Future<AuthResult> authenticate() async {
    loadingOn();
    // var result = await _authUseCase(
    //     AuthBody(loginController.text.trim(), passwordController.text.trim()));
    // if (result is Failure<void>) {
    //   return doError(error: LangKey.authError.tr());
    // }
    //
    // if (result is Success<void>) {
    //   return AuthResult.success;
    // }
    loadingOff();
    return AuthResult.denied;
  }

  Future<AuthResult> doSuccess() async {
    authFailed = false;
    return AuthResult.success;
  }

  Future<AuthResult> doError({String? error}) async {
    authFailed = true;
    if (error != null) {
      addAlert(Alert(error, style: AlertStyle.danger));
    } else {
      addAlert(Alert(error ?? 'unknown', style: AlertStyle.danger));
    }
    loadingOff();
    return AuthResult.denied;
  }

  void nodeLoginListener() {
    loginHasFocus = loginNode.hasFocus;
    notifyListeners();
  }

  void nodePassListener() {
    passHasFocus = passwordNode.hasFocus;
    notifyListeners();
  }

  void updateObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}
