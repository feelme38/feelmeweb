import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:feelmeweb/core/enum/loading_state.dart';
import 'package:feelmeweb/core/result/result_of.dart';
import 'package:feelmeweb/domain/base_use_case.dart';
import 'package:feelmeweb/presentation/alert/alert.dart';
import 'package:feelmeweb/provider/network/network_provider.dart';

class BaseViewModel extends ChangeNotifier {
  BaseViewModel({this.blockUI}) {
    _connectionStream = Connectivity().onConnectivityChanged;
    _connectionStream?.listen(_updateConnectionState);
  }

  final Function(bool)? blockUI;
  LoadingState _loadingState = LoadingState.initial;

  List<Alert> alerts = [];

  Stream<ConnectivityResult>? _connectionStream;
  bool _disposed = false;
  bool hasLoadError = false;
  bool hasInternetConnection = true;
  Future<bool> hasConnection() => hasInternet();
  Result currentResult = EmptyResult();
  Timer? _timerNotification;

  String get title => '';

  String? get subTitle => null;

  String? get atLineSubTitle => null;

  LoadingState get currentLoadingState => _loadingState;

  Future<Result<T>> executeUseCaseParam<T, Y>(BaseUseCase useCase, Y param,
      {bool showLoading = false, bool cancelLoading = false}) async {
    log('execute usecase type: ${useCase.runtimeType}, param: ${param.runtimeType}');
    if (showLoading) loadingOn();
    print(useCase.runtimeType);
    if (useCase is UseCaseParam<Result<T>, Y>) {
      Result<T> result;
      result = await useCase(param);
      result.doOnError((message, exception) {
        hasLoadError = true;
        if (exception is DioException) {
          if (exception.isNetworkError) {
            hasInternetConnection = false;
            addConnectionAlert();
          } else {
            addErrorAlert(message: message);
          }
        } else if (exception is ConnectionException) {
          hasInternetConnection = false;
          addConnectionAlert();
        } else {
          addErrorAlert(message: message);
        }
      }).doOnSuccess((value) {
        hasLoadError = false;
        hasInternetConnection = true;
      });
      if (cancelLoading) loadingOff();
      return result;
    } else if (useCase is UseCaseNameParam<Result<T>, Y>) {
      Result<T> result;
      result = await useCase(param: param);
      result.doOnError((message, exception) {
        hasLoadError = true;
        if (exception is DioException) {
          if (exception.isNetworkError) {
            hasInternetConnection = false;
            addConnectionAlert();
          } else {
            addErrorAlert(message: message);
          }
        } else if (exception is ConnectionException) {
          hasInternetConnection = false;
          addConnectionAlert();
        } else {
          addErrorAlert(message: message);
        }
      }).doOnSuccess((value) {
        hasLoadError = false;
        hasInternetConnection = true;
        if (cancelLoading) loadingOff();
      });
      if (cancelLoading) loadingOff();
      return result;
    } else {
      if (cancelLoading) loadingOff();
      return Failure(message: 'unknown use case');
    }
  }

  Future<Result<T>> executeUseCase<T>(BaseUseCase useCase,
      {bool showLoading = false, bool cancelLoading = false}) async {
    if (showLoading) loadingOn();
    if (useCase is UseCase<Result<T>>) {
      var result = await useCase();
      result.doOnError((message, exception) {
        hasLoadError = true;
        if (exception is DioException) {
          if (exception.isNetworkError) {
            hasInternetConnection = false;
            addConnectionAlert();
          } else {
            addErrorAlert(message: message);
          }
        } else if (exception is ConnectionException) {
          hasInternetConnection = false;
          addConnectionAlert();
        } else {
          addErrorAlert(message: message);
        }
      }).doOnSuccess((value) {
        hasLoadError = false;
        hasInternetConnection = true;
      });
      loadingOff();
      return result;
    } else {
      loadingOff();
      return Failure(message: 'unknown use case');
    }
  }

  void _updateConnectionState(ConnectivityResult result) {
    log('connection state changed to: $result');
    if (_disposed) return;
    hasInternetConnection = ConnectivityResult.wifi == result ||
        ConnectivityResult.mobile == result;
    if (hasInternetConnection) notifyListeners();
    if (!hasInternetConnection) addConnectionAlert();
  }

  @override
  void dispose() {
    _disposed = true;
    _timerNotification?.cancel();
    _timerNotification = null;
    _connectionStream = null;
    super.dispose();
  }

  void addAlert(Alert alert) {
    alerts.add(alert);
    notifyListeners();
    if (alert.onSubmit != null) {
      final onSubmit = alert.onSubmit;
      alert.onSubmit = () {
        onSubmit?.call();
        alerts.remove(alert);
      };
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
    _timerNotification = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == alert.hideAfterSec && !_disposed) {
        log('remove alert');
        timer.cancel();
        alerts.remove(alert);
        notifyListeners();
      }
    });
  }

  void clearAlerts() {
    log('clear alerts call');
    alerts.clear();
    _timerNotification?.cancel();
    _timerNotification = null;
    notifyListeners();
  }

  void loadingOn() {
    _loadingState = LoadingState.loading;
    if (blockUI != null) blockUI!(true);
    log('loading start');
    notifyListeners();
  }

  void loadingOff() {
    _loadingState = LoadingState.initial;
    if (blockUI != null) blockUI!(false);
    log('loading finish');
    if (!_disposed) notifyListeners();
  }

  void addErrorAlert({String? message}) {
    log('alert error added: $message');
    addAlert(Alert(message ?? '',
        style: AlertStyle.danger,
        hideAfterSec: 5,
        position: AlertPosition.top));
  }

  void addConnectionAlert({String? message}) {
    log('alert connection added: $message');
    addAlert(Alert(message ?? '',
        style: AlertStyle.connection,
        hideAfterSec: 10,
        onSubmit: () => clearAlerts(),
        position: AlertPosition.connection,
        withTopPadding: true));
  }
}
