import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/form_section.dart';
import 'package:app_cdi/pages/widgets/form_button.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';

class CDI1PalabrasPage extends StatefulWidget {
  const CDI1PalabrasPage({
    Key? key,
    required this.cdi1Id,
    this.cdi1Editado,
  }) : super(key: key);

  final int cdi1Id;
  final CDI1? cdi1Editado;

  @override
  State<CDI1PalabrasPage> createState() => _CDI1PalabrasPageState();
}

class _CDI1PalabrasPageState extends State<CDI1PalabrasPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CDI1Provider provider = Provider.of<CDI1Provider>(
        context,
        listen: false,
      );
      await provider.initState(widget.cdi1Id);
      if (widget.cdi1Editado != null) {
        provider.initEditarCDI1(widget.cdi1Editado!);
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

    final List<FormSection> secciones = [];
    for (var seccion in provider.seccionesPalabras) {
      // secciones.add(
      //   FormSection(
      //     title: seccion.tituloCompleto,
      //     palabras: seccion.palabras,
      //   ),
      // );
    }

    List<FormSection> division = [];

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
            // const PageHeader(),
            SizedBox(
              width: formSize,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...division,
                  // if (index == 3) const PreguntasLenguajeWidget(),
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
