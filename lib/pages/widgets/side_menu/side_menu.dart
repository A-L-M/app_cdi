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
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);

    final userPermissions = currentUser!.rol.permisos;

    return SizedBox(
      width: 0.067 * MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userPermissions.administracionDeUsuarios != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.5, bottom: 5.5),
                    child: MenuButton(
                      tooltip: 'Usuarios',
                      fillColor: AppTheme.of(context).primaryColor,
                      icon: Icons.group_outlined,
                      isTaped: visualState.isTaped[7],
                      onPressed: () {
                        context.pushReplacement('/usuarios');
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
