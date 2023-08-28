import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/pages/listado_cdi2_page/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/pages/widgets/side_menu/side_menu.dart';
import 'package:app_cdi/pages/widgets/top_menu/top_menu.dart';
import 'package:app_cdi/theme/theme.dart';

class ListadoCDI2Page extends StatefulWidget {
  const ListadoCDI2Page({Key? key}) : super(key: key);

  @override
  State<ListadoCDI2Page> createState() => _ListadoCDI2Page();
}

class _ListadoCDI2Page extends State<ListadoCDI2Page> {
  TextEditingController searchController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ListadoCDI2Provider provider = Provider.of<ListadoCDI2Provider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final VisualStateProvider visualState =
        Provider.of<VisualStateProvider>(context);
    visualState.setTapedOption(2);

    final ListadoCDI2Provider provider =
        Provider.of<ListadoCDI2Provider>(context);

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
                title: "CDI 2",
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SideMenuWidget(),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            //HEADER
                            const CDI2ListadoHeader(),
                            //ESTATUS STEPPER
                            const SizedBox(
                              height: 10,
                            ),
                            provider.listadoCDI2.isEmpty
                                ? const CircularProgressIndicator()
                                : Flexible(
                                    child: PlutoGrid(
                                      key: UniqueKey(),
                                      configuration: PlutoGridConfiguration(
                                        localeText:
                                            const PlutoGridLocaleText.spanish(),
                                        scrollbar:
                                            plutoGridScrollbarConfig(context),
                                        style: plutoGridStyleConfig(context),
                                        columnFilter:
                                            PlutoGridColumnFilterConfig(
                                          filters: const [
                                            ...FilterHelper.defaultFilters,
                                          ],
                                          resolveDefaultColumnFilter:
                                              (column, resolver) {
                                            return resolver<
                                                    PlutoFilterTypeContains>()
                                                as PlutoFilterType;
                                          },
                                        ),
                                      ),
                                      columns: [
                                        PlutoColumn(
                                          title: 'CDI 2 ID',
                                          field: 'cdi2_id',
                                          width: 150,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Bebé ID',
                                          field: 'bebe_id',
                                          width: 225,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Nombre Bebé',
                                          field: 'nombre_bebe',
                                          width: 250,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                          title: 'Fecha de la cita',
                                          field: 'created_at',
                                          width: 200,
                                          titleTextAlign:
                                              PlutoColumnTextAlign.center,
                                          textAlign:
                                              PlutoColumnTextAlign.center,
                                          type: PlutoColumnType.text(),
                                          enableEditingMode: false,
                                        ),
                                        PlutoColumn(
                                            title: 'Acciones',
                                            field: 'acciones',
                                            titleTextAlign:
                                                PlutoColumnTextAlign.center,
                                            textAlign:
                                                PlutoColumnTextAlign.center,
                                            type: PlutoColumnType.text(),
                                            enableEditingMode: false,
                                            renderer: (rendererContext) {
                                              final String id =
                                                  rendererContext.cell.value;
                                              CDI2? cdi2;
                                              try {
                                                cdi2 = provider.listadoCDI2
                                                    .firstWhere((element) =>
                                                        element.cdi2Id
                                                            .toString() ==
                                                        id);
                                              } catch (e) {
                                                cdi2 = null;
                                              }
                                              return Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  AnimatedHoverButton(
                                                    icon: Icons.edit,
                                                    tooltip: 'Editar CDI 2',
                                                    primaryColor:
                                                        AppTheme.of(context)
                                                            .primaryColor,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    onTap: () async {
                                                      // await provider
                                                      //     .initEditarUsuario(
                                                      //   usuario!,
                                                      // );
                                                      // if (!mounted) return;
                                                      // context.pushNamed(
                                                      //   'editar_usuario',
                                                      //   extra: usuario,
                                                      // );
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  AnimatedHoverButton(
                                                    icon: Icons
                                                        .assignment_turned_in,
                                                    tooltip: 'Calificar E3L',
                                                    primaryColor:
                                                        AppTheme.of(context)
                                                            .primaryColor,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    onTap: () async {
                                                      // await provider
                                                      //     .initEditarUsuario(
                                                      //   usuario!,
                                                      // );
                                                      // if (!mounted) return;
                                                      // context.pushNamed(
                                                      //   'editar_usuario',
                                                      //   extra: usuario,
                                                      // );
                                                    },
                                                  ),
                                                  const SizedBox(width: 5),
                                                  AnimatedHoverButton(
                                                    icon: Icons.add_chart,
                                                    tooltip: 'Generar Excel',
                                                    primaryColor:
                                                        AppTheme.of(context)
                                                            .primaryColor,
                                                    secondaryColor:
                                                        AppTheme.of(context)
                                                            .primaryBackground,
                                                    onTap: () async {
                                                      // await provider
                                                      //     .initEditarUsuario(
                                                      //   usuario!,
                                                      // );
                                                      // if (!mounted) return;
                                                      // context.pushNamed(
                                                      //   'editar_usuario',
                                                      //   extra: usuario,
                                                      // );
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
                                        provider.stateManager =
                                            event.stateManager;
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
