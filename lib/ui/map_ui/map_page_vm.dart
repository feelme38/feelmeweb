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
    List<LatLng> points = [];
    List<TodayRouteEngineer> engineerLocation = [];
    for (var route in routes) {

      final engineer = route.engineer;
      if(engineer != null) {
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
    }
    if (points.isNotEmpty) {
      final color = MapHelper.getRandomColor();
      polylineList.addAll(await MapHelper.osmPolylineList(points));
      circles.addAll(MapHelper.createCircles(points, color: color));
      markers.addAll(MapHelper.createMarkers(engineerLocation));
      notifyListeners();
    }
  }
}
