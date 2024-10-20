import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:flutter/material.dart';


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
    );
  }
}