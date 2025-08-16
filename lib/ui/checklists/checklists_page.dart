import 'package:feelmeweb/ui/checklists/checklists_view_model.dart';
import 'package:feelmeweb/ui/checklists/widgets/checklists_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/widgets/search_widget.dart';
import '../common/app_drawer.dart';

class ChecklistsPage extends StatelessWidget {
  const ChecklistsPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => ChecklistsViewModel(),
      child: const ChecklistsPage());

  @override
  Widget build(BuildContext context) {
    final users = context.watch<ChecklistsViewModel>().users;
    final viewModel = context.read<ChecklistsViewModel>();
    final checklists = context.watch<ChecklistsViewModel>().checklists;

    return BaseScreen<ChecklistsViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context),
      appBar: SearchWidget<ChecklistsViewModel>(
          context.read<ChecklistsViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final isSelectedUser = viewModel.selectedUserId == user.id;
                return ListTile(
                    title: Text(user.name),
                    tileColor:
                        isSelectedUser ? Colors.blue[100] : Colors.transparent,
                    onTap: () {
                      viewModel.loadChecklists(userId: user.id);
                    });
              },
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: ChecklistsWidget(checklists: checklists))
              ],
            ),
          )
        ],
      ),
    );
  }
}
