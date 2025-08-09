import 'package:feelmeweb/presentation/base_screen/base_screen.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/presentation/widgets/search_widget.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/inventory/inventory_view_model.dart';
import 'package:feelmeweb/ui/inventory/widgets/inventory_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  static Widget create(String userId) => ChangeNotifierProvider(
      create: (context) => InventoryViewModel(userId),
      child: const InventoryPage());

  @override
  Widget build(BuildContext context) {
    final inventory = context.watch<InventoryViewModel>().inventory;
    final viewModel = context.read<InventoryViewModel>();

    return BaseScreen<InventoryViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context),
      appBar: SearchWidget<InventoryViewModel>(
          context.read<InventoryViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (inventory != null)
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: InventoryWidget(
                        inventory: inventory,
                        checkboxValues: viewModel.checkboxValues,
                        textControllers: viewModel.textControllers),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: BaseTextButton(
                      buttonText: "Принять",
                      onTap: viewModel.updateInventory,
                      weight: FontWeight.w500,
                      fontSize: 18,
                      enabled: true,
                      textColor: Colors.white,
                      buttonColor: AppColor.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
