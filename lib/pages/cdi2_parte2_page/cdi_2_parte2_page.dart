import 'package:app_cdi/pages/cdi2_parte2_page/widgets/inciso_a_widget.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/form_button.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/cdi_2_page/widgets/form_section.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';
import 'package:app_cdi/provider/providers.dart';

class CDI2Parte2Page extends StatefulWidget {
  const CDI2Parte2Page({Key? key}) : super(key: key);

  @override
  State<CDI2Parte2Page> createState() => _CDI2Parte2PageState();
}

class _CDI2Parte2PageState extends State<CDI2Parte2Page> {
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
            return const CDI2Parte2PageDesktop();
          },
        ),
      ),
    );
  }
}

class CDI2Parte2PageDesktop extends StatefulWidget {
  const CDI2Parte2PageDesktop({Key? key}) : super(key: key);

  @override
  State<CDI2Parte2PageDesktop> createState() => _CDI2Parte2PageDesktopState();
}

class _CDI2Parte2PageDesktopState extends State<CDI2Parte2PageDesktop> {
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

    List<FormSection> division = [];

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
                  ...division,
                  CustomCard(
                    title: '2º Parte: Oraciones y gramática',
                    textAlign: TextAlign.left,
                    contentPadding: EdgeInsets.zero,
                    child: Container(),
                  ),
                  const IncisoAWidget(),
                  CustomCard(
                    title: 'B. Ejemplos',
                    child: Container(
                      child: Text('Ver'),
                    ),
                  ),
                  CustomCard(
                    title: 'C. Complejidad de frases',
                    child: Container(
                      child: Text('Ver'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormButton(
                          label: 'Retroceder',
                          onTap: () {
                            context.pushReplacement('/cdi-2');
                          },
                        ),
                        const SizedBox(width: 10),
                        FormButton(
                          label: 'Continuar',
                          onTap: () async {
                            final DatosPersonalesProvider datosPersonales =
                                Provider.of<DatosPersonalesProvider>(context,
                                    listen: false);
                            await provider
                                .generarReporteExcel(datosPersonales.id ?? '');
                            if (!mounted) return;
                            context.pushReplacement('/gracias');
                          },
                        ),
                      ],
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
