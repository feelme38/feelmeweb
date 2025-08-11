import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../presentation/base_screen/base_screen.dart';
import '../../../presentation/widgets/search_widget.dart';
import '../../common/app_table_widget.dart';
import 'route_list_view_model.dart';

class RouteListPage extends StatelessWidget {
  const RouteListPage({super.key});

  static Widget create(String userId) => ChangeNotifierProvider(
      create: (context) => RouteListViewModel(userId),
      child: const RouteListPage());

  @override
  Widget build(BuildContext context) {
    final routes = context.watch<RouteListViewModel>().routes;
    final viewModel =  context.read<RouteListViewModel>();
    return BaseScreen<RouteListViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<RouteListViewModel>(
            viewModel.onSearch, () {},
            needBottomEdge: true, needBackButton: false),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: AppTableWidget(
                dataColumns: const [
                  DataColumn(
                      label: Text('Дата старта'),
                      headingRowAlignment: MainAxisAlignment.center),
                  DataColumn(
                      label: Text('Статус маршрута'),
                      headingRowAlignment: MainAxisAlignment.center),
                  DataColumn(
                      label: Text('Адреса'),
                      headingRowAlignment: MainAxisAlignment.center),
                ],
                dataRows: routes
                    .map((route) => DataRow(
                            cells: [
                              DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text(DateFormat('dd.MM.yyyy')
                                      .format(route.routeDate)))),
                              DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      _renderRouteStatus(route.routeStatus)))),
                              DataCell(Align(
                                  alignment: Alignment.center,
                                  child: Text(route.tasks.length.toString()))),
                            ],
                            onSelectChanged: (_) {
                              viewModel.openEditRoute(route.routeDate);
                            }))
                    .toList(),
              )),
        ));
  }

  String _renderRouteStatus(String? routeStatus) {
    switch (routeStatus) {
      case 'ASSIGNED':
        return 'Назначен';
      case 'STARTED':
        return 'В работе';
      case 'PAUSED':
        return 'Перерыв';
      case 'FINISHED':
        return 'Закончен';
      default:
        return 'Без маршрута';
    }
  }
}


