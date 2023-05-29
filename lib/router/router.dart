import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/pages/formularios_page/formularios_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cdi/pages/pages.dart';
import 'package:app_cdi/services/navigation_service.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    final bool loggedIn = currentUser != null;
    final bool isLoggingIn = state.location == '/login';

    if (state.location == '/cambio_contrasena' ||
        state.location == '/cdi-1' ||
        state.location == '/cdi-2') {
      return null;
    }

    //If user is not logged in and not in the login page
    if (!loggedIn && !isLoggingIn) return '/login';

    //if user is logged in and in the login page
    if (loggedIn && isLoggingIn) return '/';

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/cdi-1',
      name: 'cdi_1',
      builder: (BuildContext context, GoRouterState state) {
        return const CDI1Page();
      },
    ),
    GoRoute(
      path: '/cdi-2',
      name: 'cdi_2',
      builder: (BuildContext context, GoRouterState state) {
        return const CDI2Page();
      },
    ),
    GoRoute(
      path: '/formularios',
      name: 'formularios',
      builder: (BuildContext context, GoRouterState state) {
        return const FormulariosPage();
      },
    ),
  ],
);
