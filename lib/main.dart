import 'dart:io';

import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/theme/theme.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:feelmeweb/provider/network/network_provider.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: getIt<RouteGenerator>().router,
      debugShowCheckedModeBanner: false,
      title: 'Панель управления системой',
      theme: AppTheme.dataLight,
    );
  }
}
