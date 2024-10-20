import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/home/root_home_viewmodel.dart';
import 'package:feelmeweb/ui/users/widgets/users_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';

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