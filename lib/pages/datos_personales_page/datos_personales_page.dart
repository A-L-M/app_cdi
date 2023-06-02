import 'package:flutter/material.dart';

import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/datos_personales_page/cards/datos_bebe_card.dart';
import 'package:app_cdi/pages/datos_personales_page/cards/busqueda_card.dart';
import 'package:app_cdi/pages/datos_personales_page/cards/info_card.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_header.dart';

class DatosPersonalesPage extends StatefulWidget {
  const DatosPersonalesPage({
    Key? key,
    required this.inventario,
  }) : super(key: key);

  final String inventario;

  @override
  State<DatosPersonalesPage> createState() => _DatosPersonalesPageState();
}

class _DatosPersonalesPageState extends State<DatosPersonalesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > mobileSize) {
            return DatosPersonalesDesktop(inventario: widget.inventario);
          } else {
            return DatosPersonalesMobile(inventario: widget.inventario);
          }
        }),
      ),
    );
  }
}

class DatosPersonalesDesktop extends StatefulWidget {
  const DatosPersonalesDesktop({
    Key? key,
    required this.inventario,
  }) : super(key: key);

  final String inventario;

  @override
  State<DatosPersonalesDesktop> createState() => _DatosPersonalesDesktopState();
}

class _DatosPersonalesDesktopState extends State<DatosPersonalesDesktop> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const DatosHeader(),
            SizedBox(
              width: 1170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          InfoCard(inventario: widget.inventario),
                          const BusquedaCard(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: DatosBebeCard(
                        inventario: widget.inventario,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatosPersonalesMobile extends StatefulWidget {
  const DatosPersonalesMobile({
    Key? key,
    required this.inventario,
  }) : super(key: key);

  final String inventario;

  @override
  State<DatosPersonalesMobile> createState() => _DatosPersonalesMobileState();
}

class _DatosPersonalesMobileState extends State<DatosPersonalesMobile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const DatosHeader(),
              InfoCard(inventario: widget.inventario),
              const BusquedaCard(),
              DatosBebeCard(
                inventario: widget.inventario,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
