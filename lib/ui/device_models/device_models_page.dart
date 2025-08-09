import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:feelmeweb/ui/device_models/device_models_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/widgets/search_widget.dart';

class DeviceModelsPage extends StatelessWidget {
  const DeviceModelsPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => DeviceModelsViewModel(),
      child: const DeviceModelsPage());

  @override
  Widget build(BuildContext context) {
    final deviceModels = context.watch<DeviceModelsViewModel>().deviceModels;
    final viewModel = context.read<DeviceModelsViewModel>();

    return BaseScreen<DeviceModelsViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context, reloadCallback: viewModel.loadDeviceModels),
      appBar: SearchWidget<DeviceModelsViewModel>(
          context.read<DeviceModelsViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: AppTableWidget(
              dataColumns: viewModel.tableDeviceModelsColumns,
              dataRows:
                  viewModel.getTableDeviceModelsRows(deviceModels, context),
            ),
          ),
        ),
      ),
    );
  }
}
