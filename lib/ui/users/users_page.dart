import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/users/users_view_model.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/widgets/search_widget.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => UsersViewModel(), child: const UsersPage());

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UsersViewModel>().users;
    final selectedRole = context.watch<UsersViewModel>().selectedRole;
    final viewModel = context.read<UsersViewModel>();

    return BaseScreen<UsersViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context, reloadCallback: viewModel.loadUsers),
        appBar: SearchWidget<UsersViewModel>(
            notActiveTitleWidget: selectedRole == null
                ? const Text('Пользователи',
                    style: const TextStyle(color: Colors.black, fontSize: 20))
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                    child: DropdownButton(
                        value: selectedRole.id,
                        onChanged: (value) {
                          viewModel.updateSelectedRole(value);
                        },
                        items: viewModel.roles.map((e) {
                          return DropdownMenuItem(
                              value: e.id,
                              child: SizedBox(width: 200, child: Text(e.name)));
                        }).toList(),
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 20))),
            context.read<UsersViewModel>().onSearch,
            () {},
            needBottomEdge: true,
            needBackButton: false),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: AppTableWidget(
                  dataColumns: viewModel.tableUsersColumns,
                  dataRows: viewModel.getTableUsersRows(users))),
        ));
  }
}
