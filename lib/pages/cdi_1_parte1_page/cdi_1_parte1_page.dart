import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/cdi_1_parte1_page/widgets/inciso_a_widget.dart';
import 'package:app_cdi/pages/cdi_1_parte1_page/widgets/inciso_b_widget.dart';
import 'package:app_cdi/pages/cdi_1_parte1_page/widgets/inciso_c_widget.dart';
import 'package:app_cdi/pages/widgets/form_button.dart';
import 'package:app_cdi/pages/widgets/page_header.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';

class CDI1Parte1Page extends StatefulWidget {
  const CDI1Parte1Page({
    Key? key,
    required this.cdi1Id,
  }) : super(key: key);

  final int cdi1Id;

  @override
  State<CDI1Parte1Page> createState() => _CDI1Parte1PageState();
}

class _CDI1Parte1PageState extends State<CDI1Parte1Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      CDI1Provider provider = Provider.of<CDI1Provider>(
        context,
        listen: false,
      );

      final success = await provider.initState(widget.cdi1Id);
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
            return CDI1Parte1PageDesktop(
              cdi1Id: widget.cdi1Id,
            );
          },
        ),
      ),
    );
  }
}

class CDI1Parte1PageDesktop extends StatefulWidget {
  const CDI1Parte1PageDesktop({
    Key? key,
    required this.cdi1Id,
  }) : super(key: key);

  final int cdi1Id;

  @override
  State<CDI1Parte1PageDesktop> createState() => _CDI2PageDesktopState();
}

class _CDI2PageDesktopState extends State<CDI1Parte1PageDesktop> {
  ScrollController scrollController = ScrollController();

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
                  const IncisoAWidget(),
                  const IncisoBWidget(),
                  const IncisoCWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FormButton(
                          label: 'Continuar',
                          onTap: () {
                            scrollController.jumpTo(0.0);

                            context.push('/cdi-1/${widget.cdi1Id.toString()}/palabras');
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
