import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';

class CDI1ListadoHeader extends StatefulWidget {
  const CDI1ListadoHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<CDI1ListadoHeader> createState() => _CDI1ListadoHeaderState();
}

class _CDI1ListadoHeaderState extends State<CDI1ListadoHeader> {
  @override
  Widget build(BuildContext context) {
    final ListadoCDI1Provider provider = Provider.of<ListadoCDI1Provider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: AnimatedHoverButton(
            tooltip: 'Descargar datos',
            primaryColor: AppTheme.of(context).primaryColor,
            secondaryColor: AppTheme.of(context).primaryBackground,
            icon: Icons.download_outlined,
            onTap: () async {
              await provider.generarReporteExcel(provider.listadoCDI1);
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
                          await provider.getListadoCDI1();
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
