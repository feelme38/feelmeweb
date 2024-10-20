import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/home/root_home_viewmodel.dart';
import 'package:feelmeweb/ui/users/users_view_model.dart';
import 'package:feelmeweb/ui/users/widgets/users_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';

class UsersPage extends StatelessWidget {

  const UsersPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => UsersViewModel(), child: const UsersPage());

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UsersViewModel>().users;

    return BaseScreen<UsersViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: AppBar(
            title: const Text('Сервисные инженеры')
        ),
        child:  Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: UsersTableWidget(
              users: users,
            ),
          ),
        )
    );
  }
}