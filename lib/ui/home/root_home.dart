import 'package:feelmeweb/ui/home/root_home_viewmodel.dart';
import 'package:feelmeweb/ui/home/widgets/users_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => RootHomeViewModel(), child: const MyHomePage());

  @override
  Widget build(BuildContext context) {
    final users = context.watch<RootHomeViewModel>().users;

    return BaseScreen<RootHomeViewModel>(
        needBackButton: false,
        needAppBar: false,
        child:  Scaffold(
          appBar: AppBar(
              title: const Text('Сервисные инженеры')
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Navigation Drawer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    //context.go('/home'); // Переход на Home
                    Navigator.pop(context); // Закрытие drawer
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    //context.go('/settings'); // Переход на Settings
                    Navigator.pop(context); // Закрытие drawer
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    // context.go('/logout'); // Переход на Logout
                    Navigator.pop(context); // Закрытие drawer
                  },
                ),
              ],
            ),
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: UsersTableWidget(
                users: users,
              ),
            ),
          ),
        )
    );
  }
}