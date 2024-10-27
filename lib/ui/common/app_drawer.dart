import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Drawer getDrawer(BuildContext context) {
  return Drawer(
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
        ListTile(
          title: const Text('Главная'),
          onTap: () {
            Navigator.pop(context);
            context.go('/home');
          },
        ),
        ExpansionTile(
            leading: const Icon(Icons.home),
            title: const Text('Пользователи'),
            children: [
              ListTile(
                title: const Text('Список'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/users');
                },
              ),
              ListTile(
                title: const Text('Добавить'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/users/add');
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
                  Navigator.pop(context);
                  context.go('/aromas');
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
            leading: const Icon(Icons.place),
            title: const Text('Районы'),
            children: [
              ListTile(
                title: const Text('Список'),
                onTap: () {
                  Navigator.pop(context);
                  context.go('/regions');
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
                  Navigator.pop(context);
                  context.go("/customers");
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
  );
}