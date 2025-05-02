import 'package:feelmeweb/presentation/base_screen/base_screen.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/presentation/widgets/search_widget.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/routes/create/create_route_view_model.dart';
import 'package:feelmeweb/ui/routes/create/widgets/choose_customers_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_route_subtasks.dart';

class CreateRouteChooseCustomersPage extends StatelessWidget {
  const CreateRouteChooseCustomersPage({super.key});

  static Widget create(String userId, bool isUpdate) => ChangeNotifierProvider(
      create: (context) => CreateRouteViewModel(userId, isUpdate),
      child: const CreateRouteChooseCustomersPage());

  @override
  Widget build(BuildContext context) {
    final regions = context.watch<CreateRouteViewModel>().regions;
    final viewModel = context.read<CreateRouteViewModel>();
    final customers = context.watch<CreateRouteViewModel>().customers;
    final selectedCustomers =
        context.watch<CreateRouteViewModel>().selectedCustomers;
    final creationStage = context.watch<CreateRouteViewModel>().creationStage;

    return BaseScreen<CreateRouteViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<CreateRouteViewModel>(
            context.read<CreateRouteViewModel>().onSearch, () {},
            needBottomEdge: true, needBackButton: false),
        child: creationStage == 1
            ? Row(children: [
                Expanded(
                    child: ListView.builder(
                        itemCount: regions.length,
                        itemBuilder: (context, index) {
                          final region = regions[index];
                          final isSelectedRegion =
                              viewModel.selectedRegionId == region.id;
                          return ListTile(
                              title: Text(region.name),
                              tileColor: isSelectedRegion
                                  ? Colors.blue[100]
                                  : Colors.transparent,
                              onTap: () {
                                viewModel.loadCustomers(region.id);
                              });
                        })),
                Expanded(
                    flex: 4,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: CreateRouteChooseCustomersWidget(
                                  customers: customers,
                                  selectedCustomers: selectedCustomers,
                                  toggleCallback: (customerId) {
                                    viewModel
                                        .toggleCustomerSelection(customerId);
                                  })),
                          Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                      width: 200,
                                      child: BaseTextButton(
                                          buttonText: "Далее",
                                          onTap: () => viewModel.nextStage(),
                                          weight: FontWeight.w500,
                                          fontSize: 18,
                                          enabled: selectedCustomers.isNotEmpty,
                                          textColor: Colors.white,
                                          buttonColor: AppColor.primary))))
                        ]))
              ])
            : const CreateRouteSubtasksWidget());
  }
}
