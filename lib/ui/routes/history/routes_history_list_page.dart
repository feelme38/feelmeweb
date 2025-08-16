import 'package:feelmeweb/data/models/response/user_response.dart';
import 'package:feelmeweb/presentation/navigation/route_generation.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/provider/di/di_provider.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../presentation/base_screen/base_screen.dart';
import '../../../presentation/widgets/search_widget.dart';
import 'routes_history_list_view_model.dart';
import 'widgets/routes_history_table_widget.dart';
import 'widgets/route_details_panel.dart';
import 'widgets/route_actions_bar.dart';

class RoutesHistoryListPage extends StatelessWidget {
  const RoutesHistoryListPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => RoutesHistoryViewModel(),
      child: const RoutesHistoryListPage());

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RoutesHistoryViewModel>();

    final paginationRoutes =
        context.watch<RoutesHistoryViewModel>().paginationRoutes;
    final routes = context.watch<RoutesHistoryViewModel>().routes;
    final users = context.watch<RoutesHistoryViewModel>().users;
    final selectedStatus =
        context.watch<RoutesHistoryViewModel>().selectedStatus;
    final selectedDate = context.watch<RoutesHistoryViewModel>().selectedDate;
    final selectedUser = context.watch<RoutesHistoryViewModel>().selectedUser;
    final selectedRoute = context.watch<RoutesHistoryViewModel>().selectedRoute;
    final currentPage = context.watch<RoutesHistoryViewModel>().currentPage;
    
    int lastPage = paginationRoutes?.meta.totalPages ?? 1;

    return BaseScreen<RoutesHistoryViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<RoutesHistoryViewModel>(
            viewModel.onSearch, () {},
            needBottomEdge: true, needBackButton: false),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Left side - Table
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: RoutesHistoryTableWidget(
                        routes: routes,
                        users: users,
                        selectedUser: selectedUser,
                        selectedDate: selectedDate,
                        selectedStatus: selectedStatus,
                        selectedRoute: selectedRoute,
                        onUserChanged: viewModel.filterByUser,
                        onDateChanged: viewModel.filterByDate,
                        onStatusChanged: viewModel.filterByStatus,
                        onRouteSelected: viewModel.selectRoute,
                      ),
                    ),
                  ),
                  // Right side - Details panel
                  Expanded(
                    flex: 1,
                    child: RouteDetailsPanel(selectedRoute: selectedRoute),
                  ),
                ],
              ),
            ),
            // Bottom actions bar
            RouteActionsBar(
              selectedRoute: selectedRoute,
              currentPage: currentPage,
              lastPage: lastPage,
              onPageChanged: viewModel.changePage,
              onCopyRoute: () {
                final engineerId = selectedRoute?.engineer?.id;
                final routeDate = selectedRoute?.routeDate;
                if (engineerId == null || routeDate == null) return;

                context.go(
                  RouteName.customerCopyRoute,
                  extra: {
                    'userId': engineerId,
                    'routeDate': routeDate
                  },
                );
              },
              onCreateRoute: () {
                final engineerId = selectedRoute?.engineer?.id;
                if (engineerId == null) return;

                final context = getIt<RouteGenerator>()
                    .navigatorKey
                    .currentContext;
                if (context == null) return;

                context.go(
                  RouteName.customerCreateRoute,
                  extra: {'userId': engineerId},
                );
              },
            ),
          ],
        ));
  }
}
