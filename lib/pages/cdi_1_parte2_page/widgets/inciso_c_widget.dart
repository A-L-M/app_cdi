import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';
import 'package:app_cdi/theme/theme.dart';

class IncisoCWidget extends StatefulWidget {
  const IncisoCWidget({super.key});

  @override
  State<IncisoCWidget> createState() => _IncisoCWidgetState();
}

class _IncisoCWidgetState extends State<IncisoCWidget> {
  final List<String> preguntas = [
    '1. Come con la cuchara o el tenedor.',
    '2. Toma algún líquido de una taza.',
    '3. Se peina o se cepilla el pelo.',
    '4. Se lava los dientes.',
    '5. Se seca la cara con una toalla.',
    '6. Se pone un sombrero.',
    '7. Se pone un zapato o calcetín.',
    '8. Se pone un collar, pulsera, reloj, etc.',
    '9. Sopla o sacude la mano para indicar que algo está caliente.',
    '10. Hace que "vuele" un avión.',
    '11. Se hace el dormido.',
    '12. Se pone el teléfono en la oreja.',
    '13. Huele flores.',
    '14. Empuja un carro o un camión.',
    '15. Avienta una pelota.',
  ];

  @override
  Widget build(BuildContext context) {
    final CDI1Provider provider = Provider.of<CDI1Provider>(context);
    final size = MediaQuery.of(context).size;

    final cellHeight = size.width > 1145 ? 75.0 : 125.0;
    final titleHeight = size.width > 857 ? 38.0 : 60.0;

    final Column columnaPreguntas = Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        preguntas.length,
        (index) => CustomTableCellText(
          label: preguntas[index],
          height: cellHeight,
          alignment: Alignment.centerLeft,
        ),
      ),
    );

    columnaPreguntas.children.insert(
      0,
      CustomTableCell(
        height: titleHeight,
        width: double.infinity,
      ),
    );

    var respuestas = provider.parte2.listaAcciones;

    final rawBody = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: columnaPreguntas),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(respuestas.length + 1, (index) {
              if (index == 0) {
                return CustomTableCellText(
                  label: 'Sí',
                  height: titleHeight,
                  fontWeight: FontWeight.w700,
                );
              }
              index -= 1;
              return CustomTableCell(
                height: cellHeight,
                child: Radio(
                  value: true,
                  groupValue: respuestas[index],
                  activeColor: AppTheme.of(context).secondaryColor,
                  onChanged: (opcion) {
                    if (opcion == null) return;
                    respuestas[index] = opcion;
                    provider.setAccionesIncisoC(opcion, index);
                    setState(() {});
                  },
                ),
              );
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(respuestas.length + 1, (index) {
              if (index == 0) {
                return CustomTableCellText(
                  label: 'No',
                  height: titleHeight,
                  fontWeight: FontWeight.w700,
                );
              }
              index -= 1;
              return CustomTableCell(
                height: cellHeight,
                child: Radio(
                  value: false,
                  groupValue: respuestas[index],
                  activeColor: AppTheme.of(context).secondaryColor,
                  onChanged: (opcion) {
                    if (opcion == null) return;
                    respuestas[index] = opcion;
                    provider.setAccionesIncisoC(opcion, index);
                    setState(() {});
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );

    Widget body;

    if (size.width > 600) {
      body = rawBody;
    } else {
      body = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600,
          child: rawBody,
        ),
      );
    }

    return CustomCard(
      title: 'C. Acciones con objetos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Su hijo(a) trata de hacer o hace algunas de las siguientes actividades?',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          body,
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
