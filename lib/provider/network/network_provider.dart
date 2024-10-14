import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:feelmeweb/provider/network/urls.dart';

import 'auth_interceptor.dart';
import 'auth_preferences.dart';
import 'log_writer_interceptor.dart';

const timeout = kDebugMode ? 8000 : 25000;

@singleton
class NetworkProvider {
  final AuthPreferences preferences;
  late Dio dio;

  NetworkProvider(this.preferences) {
    init();
  }

  Future<bool> get hasInternet async {
    final status = await Connectivity().checkConnectivity();
    return (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi);
  }

  Future<void> init() async {
    dio = Dio()
      ..options.baseUrl = Urls.baseUrlV1
      ..options.connectTimeout = const Duration(milliseconds: timeout)
      ..options.receiveTimeout = const Duration(milliseconds: timeout);
    dio.interceptors
        .addAll([AuthInterceptor(preferences, dio), LogWriterInterceptor()]);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        final isValidHost = ["192.168.1.67"].contains(host);
        return isValidHost;
      });
  }
}

extension NetworkError on DioException {
  bool get isNetworkError {
    return type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.connectionError;
  }
}

extension ResultError<T> on DioError {
  String? getErrorMessage() {
    const errorDescription = 'description';
    final responseData = response?.data;
    log(responseData.toString());
    if (responseData is String) {
      dynamic errorData = json.decode(responseData.toString());
      if (errorData is List) {
        return '${response?.statusCode}: ${errorData.map((e) => errorDescription).join(', ')}';
      } else {
        if (responseData.contains(errorDescription)) {
          return '${response?.statusCode}: ${errorData[errorDescription]}';
        }
      }
      return message;
    } else {
      if (responseData is Map<String, dynamic>) {
        if (responseData.toString().contains(errorDescription)) {
          log(responseData[errorDescription]);
          return '${response?.statusCode}: ${responseData[errorDescription]}';
        }
      } else {
        if (responseData is List) {
          log('errors ${response?.data}');
        }
      }
      return message;
    }
  }
}

extension ResponseValue<T> on Response<T> {
  bool get isSuccess => statusCode == 200 || statusCode == 201;
}

extension DioExt<T> on Dio {
  Future<Response<T>> onGet(String path,
      {Map<String, dynamic>? queryParams, Options? options}) async {
    if (await hasInternet()) {
      return get<T>(path, queryParameters: queryParams, options: options)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw ConnectionException();
      });
    } else {
      throw ConnectionException();
    }
  }

  Future<Response<T>> onPost(String path,
      {Map<String, dynamic>? data,
      dynamic multipartData,
      Options? options}) async {
    if (await hasInternet()) {
      return post<T>(path, data: data ?? multipartData, options: options)
          .timeout(const Duration(seconds: timeout), onTimeout: () {
        throw ConnectionException();
      });
    } else {
      throw ConnectionException();
    }
  }

  Future<Response<T>> onWebPost(String path,
      {Map<String, dynamic>? data}) async {
    if (await hasInternet()) {
      var response = await post<T>(path,
          data: data,
          options: Options(
            headers: {'Accept': ''},
            responseType: ResponseType.plain,
          ));
      return response;
    } else {
      throw ConnectionException();
    }
  }
}

class ConnectionException implements Exception {
  String get message => 'no connection';
}

Future<bool> hasInternet() async {
  final status = await Connectivity().checkConnectivity();
  return (status == ConnectivityResult.mobile ||
      status == ConnectivityResult.wifi);
}
