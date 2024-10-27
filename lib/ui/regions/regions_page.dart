import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/widgets/search_widget.dart';
import 'regions_view_model.dart';

class RegionsPage extends StatelessWidget {

  const RegionsPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => RegionsViewModel(), child: const RegionsPage());

  @override
  Widget build(BuildContext context) {
    final regions = context.watch<RegionsViewModel>().regions;
    final viewModel = context.read<RegionsViewModel>();

    return BaseScreen<RegionsViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<RegionsViewModel>(
          context.read<RegionsViewModel>().onSearch, () {},
          needBottomEdge: true,
          needBackButton: false,
        ),
        child:  Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AppTableWidget(
              dataColumns: viewModel.tableRegionsColumns,
              dataRows: viewModel.getTableRegionsRows(regions),
            ),
          ),
        )
    );
  }
}