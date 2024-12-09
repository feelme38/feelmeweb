import 'dart:convert';
import 'dart:math';

import 'package:base_class_gen/core/log_writer_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static const _apiKey = 'AIzaSyBLDSwffh9WtEJIz3MFLH30lETQFo5kbh0';
  static const _osmBaseUrl = 'http://router.project-osrm.org';

  static String _osmPointsReq(String coordinates) =>
      '/route/v1/driving/$coordinates?overview=full&geometries=geojson';

  static Dio _dio({bool isOsm = true}) => Dio()
    ..options = BaseOptions(
      baseUrl: isOsm ? _osmBaseUrl : 'https://maps.googleapis.com/',
    )
    ..interceptors.addAll([LogWriterInterceptor()]);

  static Future<Set<Polyline>> osmPolylineList(List<LatLng> points) async {
    // Формируем список координат для маршрута
    final coordinates =
        points.map((point) => "${point.longitude},${point.latitude}").join(';');
    final request = _osmPointsReq(coordinates);
    final result = await _dio().get(request);
    final routes = result.data['routes'] as List;
    List<LatLng> pointValues = [];
    for (var item in routes) {
      for (var coord in item['geometry']['coordinates']) {
        pointValues.add(LatLng(coord[1], coord[0]));
      }
    }
    return createPolyline(pointValues);
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

  static Set<Circle> createCircles(List<LatLng> points) {
    return points
        .asMap()
        .entries
        .map((entry) => Circle(
              circleId: CircleId("circle_${entry.key}"),
              center: entry.value,
              radius: 50,
              // Радиус круга в метрах
              fillColor: Colors.blue.withOpacity(0.5),
              strokeColor: Colors.blue,
              strokeWidth: 2,
            ))
        .toSet();
  }

  static Set<Polyline> createPolyline(List<LatLng> points) {
    return {
      Polyline(
        polylineId: PolylineId("route$points"),
        points: points,
        color: Colors.blue,
        width: 5,
      ),
    };
  }

  static Future<void> loadPolylineList(
      LatLng from, List<LatLng> waypoints) async {
    try {
      final waypointsString = waypoints
          .map((point) => "${point.latitude},${point.longitude}")
          .join('|');
      print('waypoints request ${waypoints}');
      print('from $from');
      Map<String, dynamic> queryParams = {};

      final result = await _dio(isOsm: false).get(
          'maps/api/directions/json?origin=${from.latitude},${from.longitude}&destination=${from.latitude},${from.longitude}&waypoints=optimize:true|$waypoints&key$_apiKey',
          options: Options(responseType: ResponseType.json));
      // final points = result.data['routes'][0]['overview_polyline']['points'];
      print('points ${result.data}');
    } catch (e) {
      print('cannot get data $e');
    }
  }

  static List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polyline;
  }
}

// Future<List<LatLng>> getRouteCoordinates(LatLng origin,
//     LatLng destination) async {
//   final url =
//       "https://maps.googleapis.com/maps/api/directions/json?origin=${origin
//       .latitude},${origin.longitude}&destination=${destination
//       .latitude},${destination.longitude}&key=$apiKey";
//
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//
//     if (data['routes'].isEmpty) {
//       throw Exception('No routes found');
//     }
//
//     // Decode polyline
//     final points = data['routes'][0]['overview_polyline']['points'];
//     return decodePolyline(points);
//   } else {
//     throw Exception('Failed to fetch directions');
//   }
// }
