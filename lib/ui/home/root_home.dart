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
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'FeelMe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        'Главное меню',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Пользователи'),
                    children: [
                      ListTile(
                        title: const Text('Список'),
                        onTap: () {
                          // context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                      ListTile(
                        title: const Text('Добавить'),
                        onTap: () {
                          //context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                    ]
                ),
                ExpansionTile(
                    leading: const Icon(Icons.local_florist),
                    title: const Text('Ароматы'),
                    children: [
                      ListTile(
                        title: const Text('Список'),
                        onTap: () {
                          // context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                      ListTile(
                        title: const Text('Добавить'),
                        onTap: () {
                          //context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                    ]
                ),
                ExpansionTile(
                    leading: const Icon(Icons.devices),
                    title: const Text('Оборудование'),
                    children: [
                      ListTile(
                        title: const Text('Список'),
                        onTap: () {
                          // context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                      ListTile(
                        title: const Text('Добавить'),
                        onTap: () {
                          //context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                    ]
                ),
                ExpansionTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Клиенты'),
                    children: [
                      ListTile(
                        title: const Text('Список'),
                        onTap: () {
                          // context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                      ListTile(
                        title: const Text('Добавить'),
                        onTap: () {
                          //context.go('/home'); // Переход на Home
                          Navigator.pop(context); // Закрытие drawer
                        },
                      ),
                    ]
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Выход'),
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