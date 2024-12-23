import 'package:feelmeweb/ui/aromas/aromas_page.dart';
import 'package:feelmeweb/ui/customers/customers_page.dart';
import 'package:feelmeweb/ui/regions/regions_page.dart';
import 'package:feelmeweb/ui/users/users_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:injectable/injectable.dart';
import '../../provider/di/di_provider.dart';
import '../../provider/network/auth_preferences.dart';
import '../../ui/authorization/auth_page.dart';
import '../../ui/home/root_home.dart';
import '../../ui/routes/create_route_choose_customers.dart';

@singleton
class RouteGenerator {
  RouteGenerator() {
    setup();
  }
  late final GoRouter router;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Future<bool> hasToken() async => (await getIt<AuthPreferences>().getToken())?.isNotEmpty ?? false;

  void setup() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: RouteName.auth,
      routes: <RouteBase>[
        GoRoute(
          path: RouteName.auth,
          redirect: (context, state) async {
            var hasTokenValue = await hasToken();
            if(hasTokenValue) {
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
            }
        ),
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
          path: RouteName.customerCreateRoute,
          builder: (BuildContext context, GoRouterState state) {
            final userId = state.extra as String?;
            if(userId == null) return UsersPage.create();
            return CreateRouteChooseCustomersPage.create(userId);
          },
        ),
      ],
    );
  }
}
