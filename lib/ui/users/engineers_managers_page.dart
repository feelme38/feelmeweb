import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/modals/dialogs.dart';
import '../../presentation/widgets/search_widget.dart';
import '../common/app_table_widget.dart';
import 'engineers_managers_view_model.dart';

class EngineersManagersPage extends StatelessWidget {
  const EngineersManagersPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => EngineersManagersViewModel(),
      child: const EngineersManagersPage());

  @override
  Widget build(BuildContext context) {
    final users = context.watch<EngineersManagersViewModel>().users;
    final selectedRole =
        context.watch<EngineersManagersViewModel>().selectedRole;
    final viewModel = context.read<EngineersManagersViewModel>();

    return BaseScreen<EngineersManagersViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context, reloadCallback: viewModel.loadUsers),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Dialogs.showCreateUserDialog(
                context, (body) => createUser(body, viewModel.loadUsers));
          },
          tooltip: 'Добавить пользователя',
          child: const Icon(Icons.add),
        ),
        appBar: SearchWidget<EngineersManagersViewModel>(
            notActiveTitleWidget: selectedRole == null
                ? const Text('Инженеры и менеджеры',
                    style: TextStyle(color: Colors.black, fontSize: 20))
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                    child: DropdownButton(
                        value: selectedRole!.id,
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
            context.read<EngineersManagersViewModel>().onSearch,
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


