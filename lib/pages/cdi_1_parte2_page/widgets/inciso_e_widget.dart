import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';
import 'package:app_cdi/theme/theme.dart';

class IncisoEWidget extends StatefulWidget {
  const IncisoEWidget({super.key});

  @override
  State<IncisoEWidget> createState() => _IncisoEWidgetState();
}

class _IncisoEWidgetState extends State<IncisoEWidget> {
  final List<String> preguntas = [
    '1. Barre o trapea.',
    '2. Trata de meter la llave en la puerta.',
    '3. Pega con un martillo.',
    '4. Reza o se persigna.',
    '5. Trata de escribir a máquina o computadora.',
    '6. Juega a que está leyendo.',
    '7. Fuma un cigarro.',
    '8. Le echa agua a las plantas.',
    '9. Trata de tocar un instrumento musical (guitarra, tambor, etc.).',
    '10. Juega a manejar el coche.',
    '11. Lava los platos.',
    '12. Sacude.',
    '13. Trata de escribir con un lápiz o una pluma.',
    '14. Trata de hacer un hoyo.',
    '15. Se pone unos lentes.',
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

    var respuestas = provider.parte2.listaImitaciones;

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
                    provider.setImitacionesIncisoE(opcion, index);
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
                    provider.setImitacionesIncisoE(opcion, index);
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
      title: 'E. Imitación de otros tipos de actividades de adultos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '(puede usar o no el objeto o juguete real)\n¿Su hijo(a) hace o ha tratado de hacer algunas de las siguientes actividades?',
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
