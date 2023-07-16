import 'package:app_cdi/pages/cdi_2_page/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/cdi_2_page/widgets/form_section.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';
import 'package:app_cdi/provider/providers.dart';

class CDI2Page extends StatefulWidget {
  const CDI2Page({Key? key}) : super(key: key);

  @override
  State<CDI2Page> createState() => _CDI1PageState();
}

class _CDI1PageState extends State<CDI2Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CDI2Provider provider = Provider.of<CDI2Provider>(
        context,
        listen: false,
      );
      await provider.getSeccionesPalabras();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return const CDI2PageDesktop();
            // if (constraints.maxWidth > mobileSize) {
            //   return const CDI2PageDesktop();
            // }
            // else {
            //   return const CDI2PageMobile();
            // }
          },
        ),
      ),
    );
  }
}

class CDI2PageDesktop extends StatefulWidget {
  const CDI2PageDesktop({Key? key}) : super(key: key);

  @override
  State<CDI2PageDesktop> createState() => _CDI2PageDesktopState();
}

class _CDI2PageDesktopState extends State<CDI2PageDesktop> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);

    double formSize = 1145;

    if (size.width < 1145) {
      formSize = 859.25;
    }
    if (size.width < 859.25) {
      formSize = 573.5;
    }
    if (size.width < 573.5) {
      formSize = 287.75;
    }

    // return Center(
    //   child: SizedBox(
    //     height: size.height,
    //     width: 1145,
    //     child: ListView.builder(
    //       itemCount: provider.seccionesPalabras.length,
    //       itemBuilder: (context, index) {
    //         return FormSection(
    //           title:
    //               '1.- Sonidos de las cosas y animales (MA 12 - ICPLIM 8) (Total 20)',
    //           palabras: provider.seccionesPalabras[index],
    //         );
    //       },
    //     ),
    //   ),
    // );

    // return Center(
    //   child: SizedBox(
    //     height: size.height,
    //     width: 1145,
    //     child: ListView(
    //       children: [
    //         const SizedBox(height: 50),
    //         const PageHeader(),
    //         FormSection(
    //           title:
    //               '1.- Sonidos de las cosas y animales (MA 12 - ICPLIM 8) (Total 20)',
    //           palabras: provider.palabrasSeccion1,
    //         ),
    //         FormSection(
    //           title:
    //               '2.- Animales de verdad y de juguete (MA 43 - ICPLIM 14) (Total 57)',
    //           palabras: provider.palabrasSeccion2,
    //         ),
    //         FormSection(
    //           title:
    //               '3.- Vehículos de verdad y de juguete (MA 14 - ICPLIM 7) (Total 21)',
    //           palabras: provider.palabrasSeccion3,
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    if (provider.seccionesPalabras.isEmpty) {
      return const CircularProgressIndicator();
    }

    final List<FormSection> secciones = [];
    for (var seccion in provider.seccionesPalabras) {
      secciones.add(
        FormSection(
          title: seccion.tituloCompleto,
          palabras: seccion.palabras,
        ),
      );
    }

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const PageHeader(),
            SizedBox(
              width: formSize,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...secciones,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FormButton(
                      label: 'Continuar',
                      onTap: () {
                        final DatosPersonalesProvider datosPersonales =
                            Provider.of<DatosPersonalesProvider>(context,
                                listen: false);
                        provider.generarReporteExcel(datosPersonales.id ?? '');
                        context.pushReplacement('/gracias');
                      },
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

class CDI2PageMobile extends StatefulWidget {
  const CDI2PageMobile({Key? key}) : super(key: key);

  @override
  State<CDI2PageMobile> createState() => _CDI2PageMobileState();
}

class _CDI2PageMobileState extends State<CDI2PageMobile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
