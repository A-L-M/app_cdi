import 'package:app_cdi/pages/cdi_2_page/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/form_section.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/section_title.dart';
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
                  FormSection(
                    title:
                        '1.- Sonidos de las cosas y animales (MA 12 - ICPLIM 8) (Total 20)',
                    palabras: provider.palabrasSeccion1,
                  ),
                  FormSection(
                    title:
                        '2.- Animales de verdad y de juguete (MA 43 - ICPLIM 14) (Total 57)',
                    palabras: provider.palabrasSeccion2,
                  ),
                  FormSection(
                    title:
                        '3.- Vehículos de verdad y de juguete (MA 14 - ICPLIM 7) (Total 21)',
                    palabras: provider.palabrasSeccion3,
                  ),
                  FormSection(
                    title:
                        '4.- Alimentos y bebidas (MA 68 - ICPLIM 9) (Total 77)',
                    palabras: provider.palabrasSeccion4,
                  ),
                  FormSection(
                    title: '5.- Ropa (MA 28 - ICPLIM 5) (Total 33)',
                    palabras: provider.palabrasSeccion5,
                  ),
                  FormSection(
                    title:
                        '6.- Partes del cuerpo (MA 27 - ICPLIM 6) (Total 33)',
                    palabras: provider.palabrasSeccion6,
                  ),
                  FormSection(
                    title: '7.- Juguetes (MA 18 - ICPLIM 10) (Total 28)',
                    palabras: provider.palabrasSeccion7,
                  ),
                  FormSection(
                    title:
                        '8.- Utensilios de la casa (MA 50 - ICPLIM 6) (Total 56)',
                    palabras: provider.palabrasSeccion8,
                  ),
                  FormSection(
                    title:
                        '9.- Muebles y cuartos (MA 33 - ICPLIM 3) (Total 36)',
                    palabras: provider.palabrasSeccion9,
                  ),
                  FormSection(
                    title:
                        '10.- Objetos fuera de la casa (MA 31 - ICPLIM 0) (Total 31)',
                    palabras: provider.palabrasSeccion10,
                  ),
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

            // const SectionTitle(
            //   label:
            //       '11.- Lugares fuera de la casa (MA 22 - ICPLIM 6) (Total 28)',
            // ),
            // const SectionTitle(
            //   label: '12.- Personas (MA 29 - ICPLIM 7) (Total 36)',
            // ),
            // const SectionTitle(
            //   label:
            //       '13.- Rutina diaria, reglas sociales y juegos (MA 25 - ICPLIM 6) (Total 31)',
            // ),
            // const SectionTitle(
            //   label:
            //       '14.- Acciones y procesos (verbos) (MA 103 - ICPLIM 16) (Total 119)',
            // ),
            // const SectionTitle(
            //   label: '15.- Estados (MA 3 - ICPLIM 0) (Total 3)',
            // ),
            // const SectionTitle(
            //   label:
            //       '16.- Cualidades y atributos (MA 63 - ICPLIM 10) (Total 73)',
            // ),
            // const SectionTitle(
            //   label: '17.- Tiempo (MA 12 - ICPLIM 4) (Total 16)',
            // ),
            // const SectionTitle(
            //   label:
            //       '18.- Pronombres y modificadores (MA 43 - ICPLIM 4) (Total 47)',
            // ),
            // const SectionTitle(
            //   label: '19.- Preguntas (MA 7 - ICPLIM 0) (Total 7)',
            // ),
            // const SectionTitle(
            //   label:
            //       '20.- Preposiciones y artículos (MA 15 - ICPLIM 9) (Total 23)',
            // ),
            // const SectionTitle(
            //   label:
            //       '21.- Cuantificadores y adverbios (MA 15 - ICPLIM 3) (Total 18)',
            // ),
            // const SectionTitle(
            //   label: '22.- Locativos (MA 13 - ICPLIM 8) (Total 13)',
            // ),
            // const SectionTitle(
            //   label: '23.- Conectivos (MA 6 - ICPLIM 0) (Total 6)',
            // ),
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
