import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/models/enums.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/cdi_1_provider.dart';
import 'package:app_cdi/theme/theme.dart';

class IncisoAWidget extends StatefulWidget {
  const IncisoAWidget({super.key});

  @override
  State<IncisoAWidget> createState() => _IncisoAWidgetState();
}

class _IncisoAWidgetState extends State<IncisoAWidget> {
  final List<String> preguntas = [
    '1. Extiende su brazo para mostrarle algo que tiene en su mano.',
    '2. Trata de alcanzar o darle algún juguete u objeto que tiene en la mano.',
    '3. Señala (con la mano y el dedo índice extendidos) algún objeto o situación.',
    '4. Dice "adiós" con la mano cuando alguien se va, sin que se le pida que lo haga.',
    '5. Alza los brazos para que lo levanten.',
    '6. Hace el gesto de "no" con su cabeza.',
    '7. Hace el gesto de "sí" con su cabeza.',
    '8. Hace el gesto de "shhh" (callar) con su dedo enfrente de la boca.',
    '9. Extiende su mano, a veces acompañado de un gemido u otro sonido para pedir algo.',
    '10. Avienta besitos.',
    '11. Aprieta los labios como manera de decir "mmmm" cuando algo está sabroso.',
    '12. Levanta los hombros o extiende sus manos hasta los lados como para decir "dónde está" o "se fue".',
    '13. Llama a alguien con la mano haciendo el gesto de "ven".',
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

    var respuestas = provider.parte2.listaGestos;

    final body = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            'Instrucciones: Cuando un(a) niño(a) pequeño(a) empieza a comunicarse, frecuentemente usa gestos para dar a entender sus necesidades. Por favor, rellene el círculo en la columna correspondiente de los gestos o acciones que su hijo(a) haga en este momento.',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
        ),
        Row(
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
                      label: 'Todavía no',
                      height: titleHeight,
                      fontWeight: FontWeight.w700,
                    );
                  }
                  index -= 1;
                  return CustomTableCell(
                    height: cellHeight,
                    child: Radio(
                      value: RespuestaComprension.todaviaNo,
                      groupValue: respuestas[index],
                      activeColor: AppTheme.of(context).secondaryColor,
                      onChanged: (opcion) {
                        if (opcion == null) return;
                        respuestas[index] = opcion;
                        provider.setGestosIncisoA(opcion, index);
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
                      label: 'De vez en cuando',
                      height: titleHeight,
                      fontWeight: FontWeight.w700,
                    );
                  }
                  index -= 1;
                  return CustomTableCell(
                    height: cellHeight,
                    child: Radio(
                      value: RespuestaComprension.deVezEnCuando,
                      groupValue: respuestas[index],
                      activeColor: AppTheme.of(context).secondaryColor,
                      onChanged: (opcion) {
                        if (opcion == null) return;
                        respuestas[index] = opcion;
                        provider.setGestosIncisoA(opcion, index);
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
                      label: 'Muchas veces',
                      height: titleHeight,
                      fontWeight: FontWeight.w700,
                    );
                  }
                  index -= 1;
                  return CustomTableCell(
                    height: cellHeight,
                    child: Radio(
                      value: RespuestaComprension.muchasVeces,
                      groupValue: respuestas[index],
                      activeColor: AppTheme.of(context).secondaryColor,
                      onChanged: (opcion) {
                        if (opcion == null) return;
                        respuestas[index] = opcion;
                        provider.setGestosIncisoA(opcion, index);
                        setState(() {});
                      },
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ],
    );

    if (size.width > 600) {
      return CustomCard(
        title: 'A. Primeros Gestos',
        contentPadding: EdgeInsets.zero,
        child: body,
      );
    }

    return CustomCard(
      title: 'A. Primeros Gestos',
      contentPadding: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600,
          child: body,
        ),
      ),
    );
  }
}
