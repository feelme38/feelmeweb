import 'package:flutter/material.dart';
import 'package:feelmeweb/data/models/response/route_response.dart';
import 'route_info.dart';

class RouteDetailsPanel extends StatelessWidget {
  final RouteResponse? selectedRoute;

  const RouteDetailsPanel({
    super.key,
    required this.selectedRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(left: BorderSide(color: Colors.grey.shade300)),
      ),
      child: selectedRoute == null
          ? const Center(child: Text("Маршрут не выбран"))
          : RouteInfo(selectedRoute: selectedRoute!),
    );
  }
}
