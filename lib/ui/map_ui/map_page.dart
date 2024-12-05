import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: requestPermission(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == true) {
            return FutureBuilder<LocationData>(
                future: pos(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(data?.latitude ?? 37.42796133580664,
                              data?.longitude ?? -122.085749655962),
                          zoom: 14),
                      onMapCreated: onMapCreated);
                });
          }
          return Center(
              child: GestureDetector(
                onTap: () async {
                  await requestPermission();
                  setState(() {

                  });
                },
                  child: const Text('Запросите разрешение снова')));
        });
  }

  Future<LocationData> pos() => Location().getLocation();

  Future<bool> requestPermission() async {
    final result = await Permission.location.request();
    return result.isGranted;
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
    });
  }
}
