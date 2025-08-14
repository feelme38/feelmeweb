import 'package:feelmeweb/presentation/base_screen/base_screen.dart';
import 'package:feelmeweb/presentation/widgets/search_widget.dart';
import 'package:feelmeweb/ui/common/app_drawer.dart';
import 'package:feelmeweb/ui/routes/copy/copy_route_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'copy_route_subtasks.dart';

class CopyRouteChooseCustomersPage extends StatelessWidget {
  const CopyRouteChooseCustomersPage({super.key});

  static Widget create(String userId, DateTime routeDate) =>
      ChangeNotifierProvider(
          create: (context) => CopyRouteViewModel(userId, routeDate),
          child: const CopyRouteChooseCustomersPage());

  @override
  Widget build(BuildContext context) {
    return BaseScreen<CopyRouteViewModel>(
        needBackButton: false,
        needAppBar: true,
        drawer: getDrawer(context),
        appBar: SearchWidget<CopyRouteViewModel>(
            context.read<CopyRouteViewModel>().onSearch, () {},
            needBottomEdge: true, needBackButton: false),
        child: const CopyRouteSubtasksWidget());
  }
}
