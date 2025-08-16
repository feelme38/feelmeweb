class RouteStatusHelper {
  static String renderRouteStatus(String? routeStatus) {
    switch (routeStatus) {
      case 'ASSIGNED':
        return 'Назначен';
      case 'STARTED':
        return 'В работе';
      case 'PAUSED':
        return 'Перерыв';
      case 'FINISHED':
        return 'Закончен';
      default:
        return 'Без маршрута';
    }
  }

  static String pluralizePoints(int count) {
    final lastTwoDigits = count % 100;
    final lastDigit = count % 10;

    if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
      return '$count точек в маршруте';
    }

    switch (lastDigit) {
      case 1:
        return '$count точка в маршруте';
      case 2:
      case 3:
      case 4:
        return '$count точки в маршруте';
      default:
        return '$count точек в маршруте';
    }
  }
}
