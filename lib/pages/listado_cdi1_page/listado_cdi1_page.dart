import 'package:app_cdi/helpers/functions/generar_pdf.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/pages/widgets/confirmacion_popup.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/pages/listado_cdi1_page/widgets/header.dart';
import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/pages/widgets/side_menu/side_menu.dart';
import 'package:app_cdi/pages/widgets/top_menu/top_menu.dart';
import 'package:app_cdi/theme/theme.dart';

class ListadoCDI1Page extends StatefulWidget {
  const ListadoCDI1Page({Key? key}) : super(key: key);

  @override
  State<ListadoCDI1Page> createState() => _ListadoCDI1PageState();
}

class _ListadoCDI1PageState extends State<ListadoCDI1Page> {
  TextEditingController searchController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ListadoCDI1Provider provider = Provider.of<ListadoCDI1Provider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final VisualStateProvider visualState = Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(1);

    final ListadoCDI1Provider provider = Provider.of<ListadoCDI1Provider>(context);

    final bool permisoCaptura = currentUser!.rol.permisos.administracionCDI1 == 'C';

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
                title: "CDI 1",
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
                            const CDI1ListadoHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 10,
                            ),
                            provider.listadoCDI1.isEmpty
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
                                          title: 'CDI 1 ID',
                                          field: 'cdi1_id',
                                          width: 150,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Bebé ID',
                                          field: 'bebe_id',
                                          width: 225,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Nombre Bebé',
                                          field: 'nombre_bebe',
                                          width: 250,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Edad Bebé',
                                          field: 'edad',
                                          width: 250,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Fecha de la cita',
                                          field: 'created_at',
                                          width: 200,
                                          titleTextAlign: PlutoColumnTextAlign.center,
                                          textAlign: PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            width: 300,
                                            titleTextAlign: PlutoColumnTextAlign.center,
                                            textAlign: PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              final String id = rendererContext.cell.value;
                                              CDI1? cdi1;
                                              try {
                                                cdi1 = provider.listadoCDI1
                                                    .firstWhere((element) => element.cdi1Id.toString() == id);
                                              } catch (e) {
                                                cdi1 = null;
                                              }
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  if (permisoCaptura)
                                                    AnimatedHoverButton(
                                                      icon: Icons.edit,
                                                      tooltip: 'Editar',
                                                      primaryColor: AppTheme.of(context).primaryColor,
                                                      secondaryColor: AppTheme.of(context).primaryBackground,
                                                      onTap: () async {
                                                        context.push('/cdi-1/${cdi1!.cdi1Id}');
                                                      },
                                                    ),
                                                  if (permisoCaptura) const SizedBox(width: 5),
                                                  AnimatedHoverButton(
                                                    icon: Icons.add_chart,
                                                    tooltip: 'Generar Excel',
                                                    primaryColor: AppTheme.of(context).primaryColor,
                                                    secondaryColor: AppTheme.of(context).primaryBackground,
                                                    onTap: () async {
                                                      final res = await provider.generarReporteExcel([cdi1!]);
                                                      if (!res) {
                                                        ApiErrorHandler.callToast('Error al generar Excel');
                                                        return;
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  AnimatedHoverButton(
                                                    icon: Icons.document_scanner,
                                                    tooltip: 'Generar PDF',
                                                    primaryColor: AppTheme.of(context).primaryColor,
                                                    secondaryColor: AppTheme.of(context).primaryBackground,
                                                    onTap: () async {
                                                      final res = await crearPdfCDI1(cdi1!);
                                                      if (!res) {
                                                        ApiErrorHandler.callToast('Error al generar PDF');
                                                        return;
                                                      }
                                                    },
                                                  ),
                                                  if (permisoCaptura) const SizedBox(width: 5),
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
                                                        final res = await provider.borrarCDI1(
                                                          cdi1!.cdi1Id,
                                                        );
                                                        if (!res) {
                                                          ApiErrorHandler.callToast('Error al borrar CDI');
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
