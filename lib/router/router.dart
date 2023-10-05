import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cdi/pages/alta_usuario_page/alta_usuario_page.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/pages/pages.dart';
import 'package:app_cdi/services/navigation_service.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: NavigationService.navigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/datos-personales',
      name: 'datos_personales',
      builder: (BuildContext context, GoRouterState state) {
        if (state.extra == null) return const HomePage();
        return DatosPersonalesPage(inventario: state.extra as String);
      },
    ),
    GoRoute(
      path: '/cdi-1',
      name: 'cdi_1',
      builder: (BuildContext context, GoRouterState state) {
        if (state.extra is int) {
          return CDI1Parte1Page(cdi1Id: state.extra as int);
        }
        if (state.extra is CDI1) {
          final cdi1 = (state.extra as CDI1);
          return CDI1Parte1Page(
            cdi1Id: cdi1.cdi1Id,
            cdi1Editado: cdi1,
          );
        }
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'palabras',
          name: 'palabras',
          builder: (BuildContext context, GoRouterState state) {
            if (state.extra is int) {
              return CDI1PalabrasPage(cdi1Id: state.extra as int);
            }
            return const HomePage();
          },
        ),
        GoRoute(
          path: 'parte-2',
          name: 'cdi1_parte_2',
          builder: (BuildContext context, GoRouterState state) {
            if (state.extra is int) {
              return CDI1Parte2Page(cdi1Id: state.extra as int);
            }
            return const HomePage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/cdi-2',
      name: 'cdi_2',
      builder: (BuildContext context, GoRouterState state) {
        if (state.extra is int) {
          return CDI2PalabrasPage(cdi2Id: state.extra as int);
        }
        if (state.extra is CDI2) {
          final cdi2 = (state.extra as CDI2);
          return CDI2PalabrasPage(
            cdi2Id: cdi2.cdi2Id,
            cdi2Editado: cdi2,
          );
        }
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'parte-2',
          name: 'cdi2_parte_2',
          builder: (BuildContext context, GoRouterState state) {
            if (state.extra is int) {
              return CDI2Parte2Page(cdi2Id: state.extra as int);
            }
            return const HomePage();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/gracias',
      name: 'gracias',
      builder: (BuildContext context, GoRouterState state) {
        return const GraciasPage();
      },
    ),
    GoRoute(
      path: '/bebes',
      name: 'bebes',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser == null) return const PageNotFoundPage();
        if (currentUser!.rol.permisos.administracionBebes == null) return const HomePage();
        return const BebesPage();
      },
    ),
    GoRoute(
      path: '/listado-cdi1',
      name: 'listado_cdi1',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser == null) return const PageNotFoundPage();
        if (currentUser!.rol.permisos.administracionCDI1 == null) return const HomePage();
        return const ListadoCDI1Page();
      },
    ),
    GoRoute(
      path: '/listado-cdi2',
      name: 'listado_cdi2',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser == null) return const PageNotFoundPage();
        if (currentUser!.rol.permisos.administracionCDI2 == null) return const HomePage();
        return const ListadoCDI2Page();
      },
    ),
    GoRoute(
      path: '/usuarios',
      name: 'usuarios',
      builder: (BuildContext context, GoRouterState state) {
        if (currentUser == null) return const PageNotFoundPage();
        if (currentUser!.rol.permisos.administracionDeUsuarios == null) return const HomePage();
        return const UsuariosPage();
      },
      routes: [
        GoRoute(
          path: 'alta-usuario',
          name: 'alta_usuario',
          builder: (BuildContext context, GoRouterState state) {
            if (currentUser == null) return const PageNotFoundPage();
            if (currentUser!.rol.permisos.administracionDeUsuarios == null) return const HomePage();
            return const AltaUsuarioPage();
          },
        ),
        GoRoute(
          path: 'editar-usuario',
          name: 'editar_usuario',
          builder: (BuildContext context, GoRouterState state) {
            if (currentUser == null) return const PageNotFoundPage();
            if (currentUser!.rol.permisos.administracionDeUsuarios == null) return const HomePage();
            if (state.extra == null) return const UsuariosPage();
            return AltaUsuarioPage(usuario: state.extra as Usuario);
          },
        ),
      ],
    ),
  ],
);
