import 'package:feelmeweb/ui/checklists/checklists_view_model.dart';
import 'package:feelmeweb/ui/checklists/widgets/checklist_details_panel.dart';
import 'package:feelmeweb/ui/checklists/widgets/checklists_customer_list.dart';
import 'package:feelmeweb/ui/checklists/widgets/checklists_pagination_bar.dart';
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
    final viewModel = context.read<ChecklistsViewModel>();
    final customers = context.watch<ChecklistsViewModel>().customers;
    final users = context.watch<ChecklistsViewModel>().users;
    final checklists = context.watch<ChecklistsViewModel>().checklists;
    final selectedCustomerId =
        context.watch<ChecklistsViewModel>().selectedCustomerId;
    final selectedEngineer =
        context.watch<ChecklistsViewModel>().selectedEngineer;
    final selectedDate = context.watch<ChecklistsViewModel>().selectedDate;
    final selectedChecklist =
        context.watch<ChecklistsViewModel>().selectedChecklist;
    final paginationChecklists =
        context.watch<ChecklistsViewModel>().paginationChecklists;
    final currentPage = context.watch<ChecklistsViewModel>().currentPage;

    final lastPage = paginationChecklists?.meta?.totalPages ?? 1;

    return BaseScreen<ChecklistsViewModel>(
      needBackButton: false,
      needAppBar: true,
      drawer: getDrawer(context),
      appBar: SearchWidget<ChecklistsViewModel>(
          context.read<ChecklistsViewModel>().onSearch, () {},
          needBottomEdge: true, needBackButton: false),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left side - Customer list
                Expanded(
                  child: ChecklistsCustomerList(
                    customers: customers,
                    selectedCustomerId: selectedCustomerId,
                    onCustomerSelected: viewModel.chooseCustomer,
                  ),
                ),
                // Right side - Checklists table and filters
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ChecklistsWidget(
                            checklists: checklists,
                            engineers: users,
                            selectedEngineer: selectedEngineer,
                            selectedDate: selectedDate,
                            onEngineerChanged: viewModel.filterByEngineer,
                            onDateChanged: viewModel.filterByDate,
                            selectedChecklist: selectedChecklist,
                            onChecklistSelected: viewModel.onChecklistSelected),
                      ),
                      // Pagination
                      ChecklistsPaginationBar(
                          currentPage: currentPage,
                          lastPage: lastPage,
                          onPageChanged: viewModel.changePage),
                    ],
                  ),
                ),
                Expanded(
                  child: ChecklistDetailsPanel(checklist: selectedChecklist),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
