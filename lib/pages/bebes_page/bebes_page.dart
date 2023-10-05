import 'package:app_cdi/pages/bebes_page/widgets/alta_bebe_popup.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/theme/theme.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/pages/widgets/confirmacion_popup.dart';
import 'package:app_cdi/pages/bebes_page/widgets/header.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/pages/widgets/side_menu/side_menu.dart';
import 'package:app_cdi/pages/widgets/top_menu/top_menu.dart';

class BebesPage extends StatefulWidget {
  const BebesPage({Key? key}) : super(key: key);

  @override
  State<BebesPage> createState() => _BebesPageState();
}

class _BebesPageState extends State<BebesPage> {
  TextEditingController searchController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      BebesProvider provider = Provider.of<BebesProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState = Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(0);

    final BebesProvider provider = Provider.of<BebesProvider>(context);

    final bool permisoCaptura = currentUser!.rol.permisos.administracionDeUsuarios == 'C';

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
                title: "Bebés",
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
                            const BebesPageHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 10,
                            ),
                            provider.bebes.isEmpty
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
                                          field: 'id',
                                          width: 100,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Cuidador',
                                          field: 'cuidador',
                                          width: 225,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Nombre',
                                          field: 'nombre',
                                          width: 150,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Apellido Paterno',
                                          field: 'apellido_paterno',
                                          width: 200,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Apellido Materno',
                                          field: 'apellido_materno',
                                          width: 200,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Sexo',
                                          field: 'sexo',
                                          width: 100,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Fecha de Nacimiento',
                                          field: 'fecha_nacimiento',
                                          width: 200,
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
                                              Bebe? bebe;
                                              try {
                                                bebe = provider.bebes
                                                    .firstWhere((element) => element.bebeId.toString() == id);
                                              } catch (e) {
                                                bebe = null;
                                              }
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  if (permisoCaptura)
                                                    AnimatedHoverButton(
                                                      icon: Icons.edit,
                                                      tooltip: 'Editar bebé',
                                                      primaryColor: AppTheme.of(context).primaryColor,
                                                      secondaryColor: AppTheme.of(context).primaryBackground,
                                                      onTap: () async {
                                                        provider.initEditarBebe(bebe!);
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AltaBebePopup(
                                                                bebeEditado: bebe!,
                                                              );
                                                            });
                                                      },
                                                    ),
                                                  const SizedBox(width: 5),
                                                  if (permisoCaptura)
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
                                                        final res = await provider.borrarBebe(bebe!.bebeId);
                                                        if (!res) {
                                                          ApiErrorHandler.callToast('Error al borrar bebé');
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
