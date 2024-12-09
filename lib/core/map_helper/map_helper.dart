import 'dart:math';

import 'package:base_class_gen/core/log_writer_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:feelmeweb/data/models/response/today_routes_response.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static const _osmBaseUrl = 'http://router.project-osrm.org';

  static Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // Прозрачность (255 - полностью непрозрачный)
      random.nextInt(255), // Красный (0-255)
      random.nextInt(255), // Зеленый (0-255)
      random.nextInt(255), // Синий (0-255)
    );
  }

  static String _osmPointsReq(String coordinates) =>
      '/route/v1/driving/$coordinates?overview=full&geometries=geojson';

  static Dio _dio({bool isOsm = true}) => Dio()
    ..options = BaseOptions(
      baseUrl: isOsm ? _osmBaseUrl : 'https://maps.googleapis.com/',
    )
    ..interceptors.addAll([LogWriterInterceptor()]);

  static Future<Set<Polyline>> osmPolylineList(
      List<LatLng> points, String? id, Function(String?) onPress) async {
    // Формируем список координат для маршрута
    final coordinates =
        points.map((point) => "${point.longitude},${point.latitude}").join(';');
    final request = _osmPointsReq(coordinates);
    final result = await _dio().get(request);
    print('result ${result.data}');
    final routes = result.data['routes'] as List;
    List<LatLng> pointValues = [];
    for (var item in routes) {
      for (var coord in item['geometry']['coordinates']) {
        pointValues.add(LatLng(coord[1], coord[0]));
      }
    }
    return createPolyline(pointValues, id, onPress);
  }

  static double calculateDistance(LatLng point1, LatLng point2) {
    const earthRadius = 6371e3; // Радиус Земли в метрах
    final lat1 = point1.latitude * pi / 180;
    final lat2 = point2.latitude * pi / 180;
    final deltaLat = (point2.latitude - point1.latitude) * pi / 180;
    final deltaLng = (point2.longitude - point1.longitude) * pi / 180;

    final a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  static Set<Circle> createCircles(List<LatLng> points,
      {required Color color}) {
    return points
        .asMap()
        .entries
        .map((entry) => Circle(
              circleId: CircleId("circle_${entry.key}"),
              center: entry.value,
              radius: 50,
              // Радиус круга в метрах
              fillColor: color.withOpacity(0.5),
              strokeColor: color,
              strokeWidth: 2,
            ))
        .toSet();
  }

  static Set<Marker> createMarkers(List<TodayRouteEngineer> engineers) {
    return engineers
        .asMap()
        .entries
        .map((entry) => Marker(
              markerId: MarkerId("marker_${entry.key}"),
              infoWindow: InfoWindow(
                  title: "Сервисный инженер", snippet: entry.value.name),
              position: LatLng(entry.value.lastLat!, entry.value.lastLon!),
            ))
        .toSet();
  }

  static Set<Polyline> createPolyline(
      List<LatLng> points, String? id, Function(String?) onPress) {
    return {
      Polyline(
          polylineId: PolylineId("route$id"),
          points: points,
          color: getRandomColor(),
          width: 5,
          onTap: ()=> onPress(id)),
    };
  }
}
