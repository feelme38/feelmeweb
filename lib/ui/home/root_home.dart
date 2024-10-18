import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen')
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
      body: const Center(
        child: Text('Main content goes here'),
      ),
    );
  }
}