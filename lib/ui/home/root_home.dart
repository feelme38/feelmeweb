import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/home/root_home_viewmodel.dart';
import 'package:feelmeweb/ui/map_ui/map_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => RootHomeViewModel(), child: const MyHomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сервисные инженеры')),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: getDrawer(context),
      body: MapPage.create(),
    );
  }
}
