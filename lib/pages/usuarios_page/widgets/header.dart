import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UsuariosPageHeader extends StatefulWidget {
  const UsuariosPageHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<UsuariosPageHeader> createState() => _UsuariosPageHeaderState();
}

class _UsuariosPageHeaderState extends State<UsuariosPageHeader> {
  @override
  Widget build(BuildContext context) {
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);
    final bool permisoCaptura = currentUser!.rol.permisos.administracionDeUsuarios == 'C';

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (permisoCaptura)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: AnimatedHoverButton(
              tooltip: 'Agregar',
              primaryColor: AppTheme.of(context).primaryColor,
              secondaryColor: AppTheme.of(context).primaryBackground,
              icon: Icons.person_add,
              onTap: () async {
                provider.clearControllers(notify: false);
                if (!mounted) return;
                context.pushNamed('alta_usuario');
              },
            ),
          ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
          child: Container(
            width: 250,
            height: 51,
            decoration: BoxDecoration(
              color: AppTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppTheme.of(context).primaryColor,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: Icon(
                    Icons.search,
                    color: AppTheme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: TextFormField(
                        controller: provider.busquedaController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          hintStyle: AppTheme.of(context).subtitle1.override(
                                fontSize: 14,
                                fontFamily: 'Gotham-Light',
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: false,
                              ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        style: AppTheme.of(context).subtitle1.override(
                              fontSize: 14,
                              fontFamily: 'Gotham-Light',
                              fontWeight: FontWeight.normal,
                              useGoogleFonts: false,
                            ),
                        onChanged: (value) async {
                          await provider.getUsuarios();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
