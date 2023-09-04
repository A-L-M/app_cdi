import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/enums.dart';
import 'package:app_cdi/pages/cdi2_parte2_page/widgets/inciso_a_widget.dart';
import 'package:app_cdi/pages/cdi2_parte2_page/widgets/inciso_b_widget.dart';
import 'package:app_cdi/pages/cdi2_parte2_page/widgets/inciso_c_widget.dart';
import 'package:app_cdi/pages/widgets/form_button.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';
import 'package:app_cdi/provider/providers.dart';

class CDI2Parte2Page extends StatefulWidget {
  const CDI2Parte2Page({Key? key, required this.cdi2Id}) : super(key: key);

  final int cdi2Id;

  @override
  State<CDI2Parte2Page> createState() => _CDI2Parte2PageState();
}

class _CDI2Parte2PageState extends State<CDI2Parte2Page> {
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

    if (size.width <= 1145) {
      formSize = 859.25;
    }
    if (size.width < 859.25) {
      formSize = 573.5;
    }
    if (size.width < 573.5) {
      formSize = 287.75;
    }

    final bool visible = provider.parte2.combinaPalabras != null &&
        provider.parte2.combinaPalabras != RespuestaComprension.noContesto &&
        provider.parte2.combinaPalabras != RespuestaComprension.todaviaNo;

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
                  CustomCard(
                    title: '2º Parte: Oraciones y gramática',
                    textAlign: Alignment.centerLeft,
                    contentPadding: EdgeInsets.zero,
                    child: Container(),
                  ),
                  const IncisoAWidget(),
                  if (visible) const IncisoBWidget(),
                  if (visible) const IncisoCWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormButton(
                          label: 'Retroceder',
                          onTap: () {
                            //TODO: pop en vez de push
                            context.pushReplacement(
                              '/cdi-2',
                              extra: provider.cdi2Id,
                            );
                          },
                        ),
                        const SizedBox(width: 10),
                        FormButton(
                          label: 'Continuar',
                          onTap: () async {
                            await provider.guardarFrasesIncisoB();
                            if (!mounted) return;
                            if (currentUser != null) {
                              context.pushReplacement('/listado-cdi2');
                              return;
                            }
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
