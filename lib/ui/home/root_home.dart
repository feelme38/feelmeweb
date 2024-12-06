import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/map_ui/map_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/request/create_user_body.dart';
import '../../domain/users/create_user_usecase.dart';


class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text('Сервисные инженеры')
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      drawer: getDrawer(context),
      body: MapPage(),
    );
  }
}