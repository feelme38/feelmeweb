import 'package:dio/dio.dart';
import 'auth_preferences.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._preferences, this.dio);

  final AuthPreferences _preferences;
  final Dio dio;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _preferences.getToken();
    if (token?.isNotEmpty == true) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
