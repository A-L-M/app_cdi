import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'widgets/menu_button.dart';

class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int numNotificacionesSinLeer = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState = Provider.of<VisualStateProvider>(context);

    final userPermissions = currentUser!.rol.permisos;

    return SizedBox(
      width: 0.067 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
              child: MenuButton(
                tooltip: 'Página principal',
                fillColor: AppTheme.of(context).primaryColor,
                icon: Icons.home,
                isTaped: visualState.isTaped[4],
                onPressed: () {
                  context.pushReplacement('/');
                },
              ),
            ),
            if (userPermissions.administracionBebes != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                child: MenuButton(
                  tooltip: 'Bebés',
                  fillColor: AppTheme.of(context).primaryColor,
                  icon: Icons.child_care,
                  isTaped: visualState.isTaped[0],
                  onPressed: () {
                    context.pushReplacement('/bebes');
                  },
                ),
              ),
            if (userPermissions.administracionCDI1 != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                child: MenuButton(
                  tooltip: 'CDI 1',
                  fillColor: AppTheme.of(context).primaryColor,
                  icon: Icons.list,
                  isTaped: visualState.isTaped[1],
                  onPressed: () {
                    context.pushReplacement('/listado-cdi1');
                  },
                ),
              ),
            if (userPermissions.administracionCDI2 != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                child: MenuButton(
                  tooltip: 'CDI 2',
                  fillColor: AppTheme.of(context).primaryColor,
                  icon: Icons.list,
                  isTaped: visualState.isTaped[2],
                  onPressed: () {
                    context.pushReplacement('/listado-cdi2');
                  },
                ),
              ),
            if (userPermissions.administracionDeUsuarios != null)
              Padding(
                padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                child: MenuButton(
                  tooltip: 'Usuarios',
                  fillColor: AppTheme.of(context).primaryColor,
                  icon: Icons.group_outlined,
                  isTaped: visualState.isTaped[3],
                  onPressed: () {
                    context.pushReplacement('/usuarios');
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
