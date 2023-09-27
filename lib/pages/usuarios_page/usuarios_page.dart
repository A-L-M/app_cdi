import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/theme/theme.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/usuario.dart';
import 'package:app_cdi/pages/widgets/confirmacion_popup.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/pages/usuarios_page/widgets/header.dart';
import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/pages/widgets/side_menu/side_menu.dart';
import 'package:app_cdi/pages/widgets/top_menu/top_menu.dart';
import 'package:app_cdi/provider/usuarios_provider.dart';
import 'package:app_cdi/provider/visual_state_provider.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  TextEditingController searchController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UsuariosProvider provider = Provider.of<UsuariosProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState = Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(3);

    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const TopMenuWidget(
                title: "Usuarios",
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideMenuWidget(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            //HEADER
                            const UsuariosPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 10,
                            ),
                            provider.usuarios.isEmpty
                                ? const CircularProgressIndicator()
                                : Flexible(
                                    child: PlutoGrid(
                                      key: UniqueKey(),
                                      configuration: PlutoGridConfiguration(
                                        localeText: const PlutoGridLocaleText.spanish(),
                                        scrollbar: plutoGridScrollbarConfig(context),
                                        style: plutoGridStyleConfig(context),
                                        columnFilter: PlutoGridColumnFilterConfig(
                                          filters: const [
                                            ...FilterHelper.defaultFilters,
                                          ],
                                          resolveDefaultColumnFilter: (column, resolver) {
                                            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                          },
                                        ),
                                      ),
                                      columns: [
                                        PlutoColumn(
                                          title: 'ID',
                                          field: 'id_secuencial',
                                          width: 80,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.number(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Usuario',
                                          field: 'nombre',
                                          width: 300,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Rol',
                                          field: 'rol',
                                          width: 250,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                          renderer: (rendererContext) {
                                            return Text(
                                              rendererContext.cell.value,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Gotham-Bold',
                                                fontWeight: rendererContext.cell.value == "Administrador"
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                              ),
                                            );
                                          },
                                        ),
                                        PlutoColumn(
                                          title: 'Correo',
                                          field: 'email',
                                          width: 250,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              final String id = rendererContext.cell.value;
                                              Usuario? usuario;
                                              try {
                                                usuario = provider.usuarios.firstWhere((element) => element.id == id);
                                              } catch (e) {
                                                usuario = null;
                                              }
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AnimatedHoverButton(
                                                    icon: Icons.edit,
                                                    tooltip: 'Editar Usuario',
                                                    primaryColor: AppTheme.of(context).primaryColor,
                                                    secondaryColor: AppTheme.of(context).primaryBackground,
                                                    onTap: () async {
                                                      await provider.initEditarUsuario(
                                                        usuario!,
                                                      );
                                                      if (!mounted) return;
                                                      context.pushNamed(
                                                        'editar_usuario',
                                                        extra: usuario,
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  AnimatedHoverButton(
                                                    icon: Icons.delete,
                                                    tooltip: 'Borrar',
                                                    primaryColor: AppTheme.of(context).primaryColor,
                                                    secondaryColor: AppTheme.of(context).primaryBackground,
                                                    onTap: () async {
                                                      final popupResult = await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return const ConfirmacionPopup();
                                                        },
                                                      );
                                                      if (popupResult == null || popupResult is! bool) return;
                                                      if (popupResult == false) return;
                                                      final res = await provider.borrarUsuario(usuario!.id);
                                                      if (!res) {
                                                        ApiErrorHandler.callToast('Error al usuario');
                                                        return;
                                                      }
                                                    },
                                                  ),
                                                ],
                                              );
                                            }),
                                      ],
                                      rows: provider.rows,
                                      createFooter: (stateManager) {
                                        stateManager.setPageSize(
                                          10,
                                          notify: false,
                                        );
                                        return PlutoPagination(stateManager);
                                      },
                                      onLoaded: (event) {
                                        provider.stateManager = event.stateManager;
                                      },
                                      onRowChecked: (event) {},
                                    ),
                                  ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
