import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/common/app_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/modals/dialogs.dart';
import '../../presentation/widgets/search_widget.dart';
import 'customers_view_model.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => CustomersViewModel(), child: const CustomersPage());

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomersViewModel>().customers;
    final viewModel = context.read<CustomersViewModel>();

    return BaseScreen<CustomersViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context, reloadCallback: viewModel.loadCustomers),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Dialogs.showCreateCustomerDialog(
              context, (body) => createCustomer(body, viewModel.loadCustomers));
        },
        tooltip: 'Добавить клиента',
        child: const Icon(Icons.add),
      ),
      appBar: SearchWidget<CustomersViewModel>(
        context.read<CustomersViewModel>().onSearch,
        () {},
        needBottomEdge: true,
        needBackButton: false,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: AppTableWidget(
            dataColumns: viewModel.tableCustomersColumns,
            dataRows: viewModel.getTableCustomersRows(customers, context),
          ),
        ),
      ),
    );
  }
}
