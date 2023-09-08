import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncisoBWidget extends StatefulWidget {
  const IncisoBWidget({super.key});

  @override
  State<IncisoBWidget> createState() => _IncisoBWidgetState();
}

class _IncisoBWidgetState extends State<IncisoBWidget> {
  final List<String> preguntas = [
    '1. Juega tortillitas.',
    '2. Hace ojitos.',
    '3. Juega acerrín.',
    '4. Juega pon pon tata.',
    '5. Juega a esconderse o a corretearse.',
    '6. Juega a las cosquillitas.',
    '7. Hace sana sana.',
    '8. Baila.',
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

    var respuestas = provider.parte2.listaRutinas;

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
                    provider.setRutinasIncisoB(opcion, index);
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
                    provider.setRutinasIncisoB(opcion, index);
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
      title: 'B. Juegos con adultos y rutinas',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Ha visto a su hijo(a) al hacer algunas de las siguientes actividades?',
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
