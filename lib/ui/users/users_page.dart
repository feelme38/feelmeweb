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
    final viewModel = context.read<UsersViewModel>();

    return BaseScreen<UsersViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<UsersViewModel>(
          context.read<UsersViewModel>().onSearch,
          () {},
          needBottomEdge: true,
          needBackButton: false,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AppTableWidget(
              dataColumns: viewModel.tableUsersColumns,
              dataRows: viewModel.getTableUsersRows(users),
            ),
          ),
        ));
  }
}
