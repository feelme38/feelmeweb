import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import 'aromas_view_model.dart';

class AromasPage extends StatelessWidget {

  const AromasPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => AromasViewModel(), child: const AromasPage());

  @override
  Widget build(BuildContext context) {
    final users = context.watch<AromasViewModel>().users;
    final viewModel = context.read<AromasViewModel>();

    return BaseScreen<AromasViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: AppBar(
            title: const Text('Ароматы')
        ),
        child:  Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AppTableWidget(
              dataColumns: viewModel.tableUsersColumns,
              dataRows: viewModel.getTableUsersRows(users),
            ),
          ),
        )
    );
  }
}