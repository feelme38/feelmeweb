import 'package:base_class_gen/core/ext/build_context_ext.dart';
import 'package:feelmeweb/core/map_helper/map_helper.dart';
import 'package:feelmeweb/data/models/response/today_routes_response.dart';
import 'package:feelmeweb/presentation/base_vm/base_view_model.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/route/get_routes_today_usecase.dart';
import '../../presentation/modals/dialogs.dart';

class MapPageViewModel extends BaseViewModel {
  MapPageViewModel() {
    loadRoutes();
  }

  final _loadRoutesUseCase = GetRoutesTodayUseCase();
  late GoogleMapController _controller;
  late CameraPosition initialPosition;
  List<TodayRouteResponse> routes = [];
  List<Polyline> polylineList = [];
  List<Circle> circles = [];
  List<Marker> markers = [];

  Future<void> loadRoutes() async {
    loadingOn();
    final result =
        await executeUseCase<List<TodayRouteResponse>>(_loadRoutesUseCase);

    result.doOnSuccess((value) {
      routes.addAll(value);
      loadPolylineList();
      notifyListeners();
    });
    loadingOff();
  }

  void initPosition(CameraPosition position) {}

  void initMapController(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> loadPolylineList() async {
    List<TodayRouteEngineer> engineerLocation = [];
    Map<String?, List<LatLng>> pointsByRoute = {};
    for (var route in routes) {
      List<LatLng> points = [];
      final engineer = route.engineer;
      if (engineer != null) {
        final lat = engineer.lastLat;
        final lon = engineer.lastLon;
        if (lat != null && lon != null) {
          engineerLocation.add(engineer);
        }
      }

      for (var task in route.tasks ?? <TodayRouteTask>[]) {
        final address = task.address;
        if (address != null) {
          final lat = address.lat;
          final lon = address.lng;
          if (lat != null && lon != null) {
            points.add(LatLng(lat, lon));
          }
        }
      }
      pointsByRoute[route.id] = points;
    }
    pointsByRoute.forEach((k, v) async {
      final color = MapHelper.getRandomColor();
      polylineList
          .addAll(await MapHelper.osmPolylineList(v, k, doOnPointPress));
      circles.addAll(MapHelper.createCircles(v, color: color));
      notifyListeners();
    });
    markers.addAll(MapHelper.createMarkers(engineerLocation));
    notifyListeners();
  }

  Future<void> doOnPointPress(String? routeId) async {
    final info = routes.any((e) => e.id == routeId)
        ? routes.firstWhere((e) => e.id == routeId)
        : null;
    if (info == null) return;
    final tasks = info.tasks ?? <TodayRouteTask>[];
    final client = tasks.isNotEmpty ? tasks.first.client?.name ?? '' : '';
    Dialogs.showBaseDialog(
        Dialogs.getContext(),
        Material(
            color: Colors.white,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Text('Инженер:',
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 16)),
                    const SizedBox(width: 12),
                    Text('${info.engineer?.name}',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black))
                  ],
                ),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Text('Клиент:',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                const SizedBox(width: 12),
                Text(client,
                    style: const TextStyle(fontSize: 18, color: Colors.black))
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Text('Адреса задач:',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16)),
                const SizedBox(width: 12),
                Text(tasks.map((e) => e.address?.address ?? '').join(', '),
                    style: const TextStyle(fontSize: 18, color: Colors.black))
              ]),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                BaseTextButton(
                    buttonText: 'Закрыть',
                    onTap: () {
                      Navigator.pop(Dialogs.getContext()!);
                    },
                    enabled: true)
              ])
            ])),
        width: (Dialogs.getContext()?.currentSize.width ?? 0) * 0.4);
  }
}
