import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/pages/cdi_1_parte2_page/widgets/inciso_a_widget.dart';
import 'package:app_cdi/pages/cdi_1_parte2_page/widgets/inciso_b_widget.dart';
import 'package:app_cdi/pages/cdi_1_parte2_page/widgets/inciso_c_widget.dart';
import 'package:app_cdi/pages/cdi_1_parte2_page/widgets/inciso_d_widget.dart';
import 'package:app_cdi/pages/cdi_1_parte2_page/widgets/inciso_e_widget.dart';
import 'package:app_cdi/pages/widgets/form_button.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';

class CDI1Parte2Page extends StatefulWidget {
  const CDI1Parte2Page({Key? key}) : super(key: key);

  @override
  State<CDI1Parte2Page> createState() => _CDI1Parte2PageState();
}

class _CDI1Parte2PageState extends State<CDI1Parte2Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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

    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
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
                      const IncisoAWidget(),
                      const IncisoBWidget(),
                      const IncisoCWidget(),
                      const IncisoDWidget(),
                      const IncisoEWidget(),
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
                                if (context.canPop()) context.pop();
                              },
                            ),
                            const SizedBox(width: 10),
                            FormButton(
                              key: UniqueKey(),
                              label: 'Continuar',
                              onTap: () async {
                                if (!mounted) return;
                                if (currentUser != null) {
                                  if (!currentUser!.esVisitante) {
                                    context.pushReplacement('/listado-cdi1');
                                    return;
                                  }
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
        ),
      ),
    );
  }
}
