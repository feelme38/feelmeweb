import 'package:feelmeweb/core/enum/loading_state.dart';
import 'package:feelmeweb/ui/map_ui/map_page_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();

  static Widget create() => ChangeNotifierProvider(
      create: (context) => MapPageViewModel(), child: const MapPage());
}

class _MapPageState extends State<MapPage> {
  late final vm = context.read<MapPageViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var routes = context.watch<MapPageViewModel>().routes;
    var isLoading =
        context.watch<MapPageViewModel>().currentLoadingState.isLoading;
    if (isLoading) return Container();

    if (routes.isEmpty) return const Center(child: Text('Заданий не найдено'));
    if (routes.every((e) => e.tasks == null || e.tasks!.isEmpty)) {
      return const Center(child: Text('Заданий не найдено'));
    }
    if (routes.any((e) => e.tasks?.every((e) => e.address == null) == true)) {
      return const Center(child: Text('Маршрутов по заданиям не найдено'));
    }
    final initialRoute = routes
        .firstWhere((e) => e.tasks != null && e.tasks?.isNotEmpty == true)
        .tasks
        ?.firstWhere((e) => e.address != null && e.address!.lat != null);
    return GoogleMap(
        polylines: context.watch<MapPageViewModel>().polylineList.toSet(),
        circles: context.watch<MapPageViewModel>().circles.toSet(),
        markers: context.watch<MapPageViewModel>().markers.toSet(),
        initialCameraPosition: CameraPosition(
            target:
                LatLng(initialRoute!.address!.lat!, initialRoute.address!.lng!),
            zoom: 14),
        onMapCreated: vm.initMapController);
  }

  Future<LocationData> pos() => Location().getLocation();

  Future<bool> requestPermission() async {
    final result = await Permission.location.request();
    return result.isGranted;
  }
}
