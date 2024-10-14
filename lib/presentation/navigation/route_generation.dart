import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:feelmeweb/presentation/navigation/route_names.dart';
import 'package:injectable/injectable.dart';

import '../../main.dart';
import '../../ui/authorization/auth_page.dart';

@singleton
class RouteGenerator {
  RouteGenerator() {
    setup();
  }
  late final GoRouter router;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void setup() {
    router = GoRouter(
      navigatorKey: navigatorKey,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const MyHomePage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: RouteName.auth,
              builder: (BuildContext context, GoRouterState state) {
                return AuthPage.create();
              },
            ),
          ],
        ),
      ],
    );
  }
}
