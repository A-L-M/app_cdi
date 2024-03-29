import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/widgets/form_button.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/palabras_section.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';

class CDI2PalabrasPage extends StatefulWidget {
  const CDI2PalabrasPage({
    Key? key,
    required this.cdi2Id,
  }) : super(key: key);

  final int cdi2Id;

  @override
  State<CDI2PalabrasPage> createState() => _CDI2PalabrasPageState();
}

class _CDI2PalabrasPageState extends State<CDI2PalabrasPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CDI2Provider provider = Provider.of<CDI2Provider>(
        context,
        listen: false,
      );
      final success = await provider.initState(widget.cdi2Id);
      if (!mounted) return;
      if (!success) {
        context.pushReplacement('/no-encontrado');
        return;
      }
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
            return CDI2PageDesktop(
              cdi2Id: widget.cdi2Id,
            );
          },
        ),
      ),
    );
  }
}

class CDI2PageDesktop extends StatefulWidget {
  const CDI2PageDesktop({
    Key? key,
    required this.cdi2Id,
  }) : super(key: key);
  final int cdi2Id;

  @override
  State<CDI2PageDesktop> createState() => _CDI2PageDesktopState();
}

class _CDI2PageDesktopState extends State<CDI2PageDesktop> {
  int index = 1;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);

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
            aclaracion: seccion.seccionId == 6 || seccion.seccionId == 12,
          ),
        ),
      );
    }

    List<CustomCard> division = [];

    if (index == 1) {
      division = secciones.sublist(0, 8);
    } else if (index == 2) {
      division = secciones.sublist(8, 16);
    } else {
      division = secciones.sublist(16);
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
                  ...division,
                  if (index == 3) const PreguntasLenguajeWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (index != 1)
                          FormButton(
                            label: 'Retroceder',
                            onTap: () {
                              index -= 1;
                              scrollController.jumpTo(0.0);
                              setState(() {});
                            },
                          ),
                        if (index != 1) const SizedBox(width: 10),
                        FormButton(
                          label: 'Continuar',
                          onTap: () {
                            if (index != 3) {
                              index += 1;
                              scrollController.jumpTo(0.0);
                              setState(() {});
                              return;
                            }
                            index = 1;
                            context.push('/cdi-2/${widget.cdi2Id}/parte-2');
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
