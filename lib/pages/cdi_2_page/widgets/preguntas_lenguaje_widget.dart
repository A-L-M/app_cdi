import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PreguntasLenguajeWidget extends StatefulWidget {
  const PreguntasLenguajeWidget({super.key});

  @override
  State<PreguntasLenguajeWidget> createState() => _PreguntasLenguajeWidgetState();
}

class _PreguntasLenguajeWidgetState extends State<PreguntasLenguajeWidget> {
  final List<String> preguntas = [
    '1.- ¿Su hijo(a) habla de situaciones del pasado? Por ejemplo, si unos días antes fueron al circo y vieron un payaso, ¿lo menciona después?',
    '2.- ¿Su hijo(a) habla sobre objetos que no están presentes? Por ejemplo, ¿pide un juguete favorito o un alimento, o pregunta por una persona cuando no la puede ver?',
    '3.- ¿Su hijo(a) habla de situaciones que van a suceder en el futuro? Por ejemplo, al ponerse el suéter, ¿Dice que va a ir a los columpios o le platica a otra persona que va a ver a su abuelita?',
    '4.- ¿Su hijo(a) entiende cuando le piden que traiga algo de otro cuarto? Por ejemplo, si le preguntan, "¿Dónde está tu pelota?", ¿el(la) niño(a) va a buscarla a otro cuarto?',
    '5.- ¿Al señalar o tomar un objeto, su hijo(a) dice el nombre de la persona a la que pertenece aunque esa persona no esté presente?, Por ejemplo, ¿Encuentra los lentes de su papá y dice "papá"?',
  ];

  @override
  Widget build(BuildContext context) {
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);
    final size = MediaQuery.of(context).size;

    final cellHeight = size.width > 1145 ? 85.0 : 175.0;
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

    var respuestas = provider.comprension.preguntas;

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
                    provider.setOpcionComprension(opcion, index);
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
                    provider.setOpcionComprension(opcion, index);
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
                    provider.setOpcionComprension(opcion, index);
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
        title: 'Cómo usa y comprende el niño el lenguaje',
        contentPadding: EdgeInsets.zero,
        textAlign: Alignment.centerLeft,
        child: body,
      );
    }

    return CustomCard(
      title: 'Cómo usa y comprende el niño el lenguaje',
      contentPadding: EdgeInsets.zero,
      textAlign: Alignment.centerLeft,
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

class CustomTableCellText extends StatelessWidget {
  const CustomTableCellText(
      {super.key, required this.label, this.height, this.fontWeight, this.alignment = Alignment.center});

  final String label;
  final double? height;
  final FontWeight? fontWeight;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.robotoSlab(
          fontSize: 14,
          fontWeight: fontWeight,
          color: const Color(0xFF2B2B2B),
        ),
        // textAlign: TextAlign.right,
      ),
    );
  }
}

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    super.key,
    this.child,
    this.height = 75,
    this.width,
  });

  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFDDDDDD),
          ),
        ),
        child: child,
      ),
    );
  }
}
