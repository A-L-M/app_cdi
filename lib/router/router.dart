import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cdi/pages/pages.dart';
import 'package:app_cdi/services/navigation_service.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/',
  // redirect: (BuildContext context, GoRouterState state) {
  //   final bool loggedIn = false;
  //   final bool isLoggingIn = state.location == '/login';

  //   //If user is not logged in and not in the login page
  //   if (!loggedIn && !isLoggingIn) return '/login';

  //   //if user is logged in and in the login page
  //   if (loggedIn && isLoggingIn) return '/';

  //   return null;
  // },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
