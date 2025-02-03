import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:feelmeweb/ui/aromas/aromas_page.dart';
import 'package:feelmeweb/ui/checklists/checklists_page.dart';
import 'package:feelmeweb/ui/customers/customers_page.dart';
import 'package:feelmeweb/ui/inventory/inventory_page.dart';
import 'package:feelmeweb/ui/regions/regions_page.dart';
import 'package:feelmeweb/ui/route_info/route_info_page.dart';
import 'package:feelmeweb/ui/routes/create/create_route_choose_customers.dart';
import 'package:feelmeweb/ui/routes/edit/edit_route_page.dart';
import 'package:feelmeweb/ui/users/users_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../provider/di/di_provider.dart';
import '../../provider/network/auth_preferences.dart';
import '../../ui/authorization/auth_page.dart';
import '../../ui/home/root_home.dart';

@singleton
class RouteGenerator {
  RouteGenerator() {
    setup();
  }
  late final GoRouter router;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<bool> hasToken() async =>
      (await getIt<AuthPreferences>().getToken())?.isNotEmpty ?? false;

  void setup() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: RouteName.auth,
      routes: <RouteBase>[
        GoRoute(
          path: RouteName.auth,
          redirect: (context, state) async {
            var hasTokenValue = await hasToken();
            if (hasTokenValue) {
              return RouteName.home;
            } else {
              return RouteName.auth;
            }
          },
          builder: (BuildContext context, GoRouterState state) {
            return AuthPage.create();
          },
        ),
        GoRoute(
            path: RouteName.home,
            builder: (BuildContext context, GoRouterState state) {
              return MyHomePage.create();
            }),
        GoRoute(
          path: RouteName.usersList,
          builder: (BuildContext context, GoRouterState state) {
            return UsersPage.create();
          },
        ),
        GoRoute(
          path: RouteName.aromasList,
          builder: (BuildContext context, GoRouterState state) {
            return AromasPage.create();
          },
        ),
        GoRoute(
          path: RouteName.customersList,
          builder: (BuildContext context, GoRouterState state) {
            return CustomersPage.create();
          },
        ),
        GoRoute(
          path: RouteName.regions,
          builder: (BuildContext context, GoRouterState state) {
            return RegionsPage.create();
          },
        ),
        GoRoute(
          path: RouteName.checklists,
          builder: (BuildContext context, GoRouterState state) {
            return ChecklistsPage.create();
          },
        ),
        GoRoute(
          path: RouteName.customerCreateRoute,
          builder: (BuildContext context, GoRouterState state) {
            final extra = state.extra as Map<String, dynamic>?;
            final userId = extra?['userId'] as String?;
            final isUpdate = extra?['isUpdate'] as bool?;
            if (userId == null) return UsersPage.create();
            return CreateRouteChooseCustomersPage.create(
                userId, isUpdate ?? false);
          },
        ),
        GoRoute(
          path: RouteName.customerEditRoute,
          builder: (BuildContext context, GoRouterState state) {
            final userId = state.extra as String?;
            if (userId == null) return UsersPage.create();
            return EditRoutePage.create(userId);
          },
        ),
        GoRoute(
          path: RouteName.routeInfo,
          builder: (BuildContext context, GoRouterState state) {
            final userId = state.extra as String?;
            if (userId == null) return UsersPage.create();
            return RouteInfoPage.create(userId);
          },
        ),
        GoRoute(
          path: RouteName.inventory,
          builder: (BuildContext context, GoRouterState state) {
            return InventoryPage.create();
          },
        ),
      ],
    );
  }

  void popUntilPath(BuildContext context, String routePath) {
    while (router
            .routerDelegate.currentConfiguration.matches.last.matchedLocation !=
        routePath) {
      if (!context.canPop()) {
        return;
      }
      context.pop();
    }
  }
}
