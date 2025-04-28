import 'package:feelmeweb/data/models/request/create_aroma_body.dart';
import 'package:feelmeweb/data/models/request/create_region_body.dart';
import 'package:feelmeweb/domain/regions/create_region_usecase.dart';
import 'package:feelmeweb/presentation/modals/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/request/create_user_body.dart';
import '../../domain/aromas/create_aroma_use_case.dart';
import '../../domain/customers/create_customer_usecase.dart';
import '../../domain/users/create_user_usecase.dart';

Future<void> createCustomer(
    CreateCustomerBody body, Function()? reloadCallback) async {
  await CreateCustomerUseCase().call(body);
  reloadCallback?.call();
}

Future<void> createUser(CreateUserBody body, Function()? reloadCallback) async {
  await CreateUserUseCase().call(body);
  reloadCallback?.call();
}

Future<void> createAroma(
    CreateAromaBody body, Function()? reloadCallback) async {
  await CreateAromaUseCase().call(body);
  reloadCallback?.call();
}

Future<void> createRegion(
    CreateRegionBody body, Function()? reloadCallback) async {
  await CreateRegionUseCase().call(body);
  reloadCallback?.call();
}

Drawer getDrawer(BuildContext context, {Function()? reloadCallback}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FeelMe',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  Text('Главное меню',
                      style: TextStyle(color: Colors.white, fontSize: 16))
                ])),
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
                  }),
              ListTile(
                  title: const Text('Добавить'),
                  onTap: () async {
                    Navigator.pop(context);
                    Dialogs.showCreateUserDialog(
                        context, (body) => createUser(body, reloadCallback));
                  })
            ]),
        ExpansionTile(
            leading: const Icon(Icons.local_florist),
            title: const Text('Ароматы'),
            children: [
              ListTile(
                  title: const Text('Список'),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/aromas');
                  }),
              ListTile(
                  title: const Text('Добавить'),
                  onTap: () {
                    Navigator.pop(context);
                    Dialogs.createAromaDialog(
                        context, (body) => createAroma(body, reloadCallback));
                  })
            ]),
        ExpansionTile(
            leading: const Icon(Icons.devices),
            title: const Text('Типы оборудования'),
            children: [
              ListTile(
                  title: const Text('Список'),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/device-models');
                  }),
              ListTile(
                  title: const Text('Добавить'),
                  onTap: () {
                    // TODO: Implement create device model dialog
                    Navigator.pop(context);
                  })
            ]),
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
                  Navigator.pop(context);
                  Dialogs.createRegionDialog(
                      context, (body) => createRegion(body, reloadCallback));
                },
              ),
            ]),
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
                  Navigator.pop(context);
                  Dialogs.showCreateCustomerDialog(
                      context, (body) => createCustomer(body, reloadCallback));
                },
              ),
            ]),
        ListTile(
          leading: const Icon(Icons.checklist_outlined),
          title: const Text('Чек-листы'),
          onTap: () {
            Navigator.pop(context);
            context.go("/check-lists");
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Выход'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
