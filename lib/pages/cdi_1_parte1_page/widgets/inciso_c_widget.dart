import 'package:app_cdi/models/enums.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncisoCWidget extends StatefulWidget {
  const IncisoCWidget({super.key});

  @override
  State<IncisoCWidget> createState() => _IncisoCWidgetState();
}

class _IncisoCWidgetState extends State<IncisoCWidget> {
  final List<String> preguntas = [
    '1.- Algunos niños repiten las cosas que escuchan. A veces repiten parte de una frase, por ejemplo, si oyen "el coche de papá" dicen "papá" o "coche". Otras veces pueden repetir una palabra nueva para ellos. ¿Con qué frecuencia cree usted que su hijo(a) imite palabras o partes de frases?',
    '2.- Algunos niños nombran cosas que ven. Se pasean por la casa y al ver objetos o personas, dicen sus nombres. ¿Con qué frecuencia cree usted que su hijo(a) haga esto?',
  ];

  @override
  Widget build(BuildContext context) {
    final CDI1Provider provider = Provider.of<CDI1Provider>(context);
    final size = MediaQuery.of(context).size;

    final cellHeight = size.width > 1145 ? 100.0 : 125.0;
    final titleHeight = size.width > 857 ? 38.0 : 60.0;

    final Column columnaPreguntas = Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        preguntas.length,
        (index) => CustomTableCellText(
          label: preguntas[index],
          height: cellHeight,
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

    var respuestas = provider.parte1.listaHablar;

    final body = Row(
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
                    provider.setManeraHablarIncisoC(opcion, index);
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
                    provider.setManeraHablarIncisoC(opcion, index);
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
                    provider.setManeraHablarIncisoC(opcion, index);
                    setState(() {});
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );

    if (size.width > 600) {
      return CustomCard(
        title: 'C. Maneras de hablar',
        contentPadding: EdgeInsets.zero,
        child: body,
      );
    }

    return CustomCard(
      title: 'C. Maneras de hablar',
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
