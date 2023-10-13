import 'package:app_cdi/pages/cdi_1_palabras_page/widgets/palabras_section.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/widgets/form_button.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';

class CDI1PalabrasPage extends StatefulWidget {
  const CDI1PalabrasPage({
    Key? key,
    required this.cdi1Id,
  }) : super(key: key);

  final int cdi1Id;

  @override
  State<CDI1PalabrasPage> createState() => _CDI1PalabrasPageState();
}

class _CDI1PalabrasPageState extends State<CDI1PalabrasPage> {
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
            return const CDI1PalabrasPageDesktop();
          },
        ),
      ),
    );
  }
}

class CDI1PalabrasPageDesktop extends StatefulWidget {
  const CDI1PalabrasPageDesktop({Key? key}) : super(key: key);

  @override
  State<CDI1PalabrasPageDesktop> createState() => _CDI2PageDesktopState();
}

class _CDI2PageDesktopState extends State<CDI1PalabrasPageDesktop> {
  int index = 1;
  ScrollController scrollController = ScrollController();

  Map<int, String> instrucciones = {
    11: 'Los niños les dicen de manera diferente a sus parientes. A veces le dicen "tía" o "abuela" o en otros casos le dicen por su nombre o por su nombre de cariño, por ejemplo, "Chacha". Si su hijo(a) hace cualquiera de las dos cosas, dice "tía" o "Chacha", rellene el círculo de la palabra indicada en la columna correspondiente.',
    13: 'Cuando los niños hablan, por lo general, usan verbos en distintas formas. Por ejemplo, pueden decir "abrir", "abrí", "abre", "está abierto" o "se abrió". Si su hijo(a) comprende o usa algunos de los verbos de la lista en cualquier forma o conjugación, por favor, rellene el círculo de la palabra indicada en la columna correspondiente.',
    16: 'Muchas de estas palabras pueden aparecer en masculino, por ejemplo, "bueno", o en femenino "buena". Si su hijo(a) comprende o comprende y dice la palabra en cualquiera de las dos formas, por favor, rellene el círculo de la palabra en la columna correspondiente.',
    17: 'Su hijo(a) puede comprender o decir y comprender estas palabras solas, por ejemplo, "ésta" o junto con otra palabra, como "dámelo". Rellene el círculo de la columna correspondiente si su hijo(a) comprende o comprende y dice algunas de las palabras de la lista. Recuerde que no importa si lo dice en forma separada o como parte de otra palabra.',
  };

  Map<int, String> aclaraciones = {
    6: 'o la palabra que use su familia para esto',
    11: 'o el nombre de esta persona',
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CDI1Provider provider = Provider.of<CDI1Provider>(context);

    double formSize = 1145;

    if (size.width <= 1145) {
      formSize = 859.25;
    }
    if (size.width <= 859) {
      formSize = 573.5;
    }
    if (size.width < 573.5) {
      formSize = 287.75;
    }

    if (provider.seccionesPalabras.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<CustomCard> secciones = [];
    for (var seccion in provider.seccionesPalabras) {
      secciones.add(
        CustomCard(
          title: seccion.tituloCompleto,
          contentPadding: EdgeInsets.zero,
          textAlign: Alignment.centerLeft,
          child: PalabrasSection(
            palabras: seccion.palabras,
            instrucciones: instrucciones[seccion.seccionId],
            aclaracion: aclaraciones[seccion.seccionId],
          ),
        ),
      );
    }

    List<CustomCard> division = [];

    if (index == 1) {
      division = secciones.sublist(0, 11);
    } else {
      division = secciones.sublist(11);
    }

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        controller: scrollController,
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
                  CustomCard(
                    title: 'Instrucciones',
                    child: Text(
                      'A continuación encontrará una lista de palabras frecuentes en el vocabulario de los niños pequeños. Si su hijo(a) ya comprende, pero no dice palabras, rellene el círculo de la palabra correspondiente en la columna que dice "comprende". Si su hijo(a) dice palabras de la lista aunque de manera distinta (p. ej., "bobo" por "osos" o "ba" por "pelota") o con diferente pronunciación (p. ej., "tete" por "leche"), o si su hijo(a) dice otra palabra que se usa en su familia y que significa lo mismo que la que viene en el cuestionario (p. ej., si dice "Coca" en vez de "refresco", o "súper" en vez de "tienda", o "Kleenex" en vez de "pañuelo"), rellene el círculo de la palabra correspondiente en la columna "comprende y dice". Recuerde que esta lista incluye las palabras que muchos niños comprenden o pueden decir. No se preocupe si su hijo(a) no comprende o no dice todas las palabras.',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                  ),
                  ...division,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormButton(
                          key: UniqueKey(),
                          label: 'Retroceder',
                          onTap: () {
                            if (index == 1) {
                              context.pop();
                              return;
                            }
                            index -= 1;
                            scrollController.jumpTo(0.0);
                            setState(() {});
                          },
                        ),
                        const SizedBox(width: 10),
                        FormButton(
                          key: UniqueKey(),
                          label: 'Continuar',
                          onTap: () {
                            if (index != 2) {
                              index += 1;
                              scrollController.jumpTo(0.0);
                              setState(() {});
                              return;
                            }
                            index = 1;
                            context.push(
                              '/cdi-1/parte-2',
                              extra: provider.cdi1Id,
                            );
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
