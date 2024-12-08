import 'package:feelmeweb/core/map_helper/map_helper.dart';
import 'package:feelmeweb/data/models/response/today_routes_response.dart';
import 'package:feelmeweb/presentation/base_vm/base_view_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/route/get_routes_today_usecase.dart';

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
    List<LatLng> points = [];
    for (var route in routes) {
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
    }
    if (points.isNotEmpty) {
      polylineList.addAll(MapHelper.createPolyline(points));
      circles.addAll(MapHelper.createCircles(points));
      notifyListeners();
    }
  }
}
