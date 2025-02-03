import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/ui/route_info/route_info_view_model.dart';
import 'package:feelmeweb/ui/route_info/widgets/route_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/widgets/search_widget.dart';
import '../common/app_drawer.dart';

class RouteInfoPage extends StatelessWidget {
  const RouteInfoPage({super.key});

  static Widget create(String userId) => ChangeNotifierProvider(
      create: (context) => RouteInfoViewModel(userId),
      child: const RouteInfoPage());

  @override
  Widget build(BuildContext context) {
    final activeCustomers = context.watch<RouteInfoViewModel>().activeCustomers;
    final viewModel = context.read<RouteInfoViewModel>();

    return BaseScreen<RouteInfoViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context),
      appBar: SearchWidget<RouteInfoViewModel>(
          context.read<RouteInfoViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: activeCustomers.length,
                    itemBuilder: (context, index) {
                      final client = activeCustomers[index].customer;
                      final isSelectedClient =
                          viewModel.selectedCustomer == client;
                      return ListTile(
                          title: Text(client.name),
                          tileColor: isSelectedClient
                              ? Colors.blue[100]
                              : Colors.transparent,
                          onTap: () {
                            viewModel.chooseCustomer(client);
                          });
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RouteInfoWidget(
                          subtasks: activeCustomers
                              .where((e) =>
                                  e.customer == viewModel.selectedCustomer)
                              .expand((e) => e.subtasks)
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 200,
              child: BaseTextButton(
                  buttonText: "Инвентарь СИ",
                  onTap: () =>
                      context.go(RouteName.inventory, extra: viewModel.userId),
                  weight: FontWeight.w500,
                  fontSize: 14,
                  enabled: true,
                  textColor: Colors.white,
                  buttonColor: AppColor.primary),
            ),
          ),
        ],
      ),
    );
  }
}
