import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum OpcionPregunta { todaviaNo, deVezEnCuando, muchasVeces, noContesto }

class PreguntasLenguajeWidget extends StatefulWidget {
  const PreguntasLenguajeWidget({super.key});

  @override
  State<PreguntasLenguajeWidget> createState() =>
      _PreguntasLenguajeWidgetState();
}

class _PreguntasLenguajeWidgetState extends State<PreguntasLenguajeWidget> {
  final List<String> preguntas = [
    '1.- ¿Su hijo(a) habla de situaciones del pasado? Por ejemplo, si unos días antes fueron al circo y vieron un payaso, ¿lo menciona después?',
    '2.- ¿Su hijo(a) habla sobre objetos que no están presentes? Por ejemplo, ¿pide un juguete favorito o un alimento, o pregunta por una persona cuando no la puede ver?',
    '3.- ¿Su hijo(a) habla de situaciones que van a suceder en el futuro? Por ejemplo, al ponerse el suéter, ¿Dice que va a ir a los columpios o le platica a otra persona que va a ver a su abuelita?',
    '4.- ¿Su hijo(a) entiende cuando le piden que traiga algo de otro cuarto? Por ejemplo, si le preguntan, "¿Dónde está tu pelota?", ¿el(la) niño(a) va a buscarla a otro cuarto?',
    '5.- ¿Al señalar o tomar un objeto, su hijo(a) dice el nombre de la persona a la que pertenece aunque esa persona no esté presente?, Por ejemplo, ¿Encuentra los lentes de su papá y dice "papá"?',
  ];

  final List<OpcionPregunta> respuestas = [
    OpcionPregunta.noContesto,
    OpcionPregunta.noContesto,
    OpcionPregunta.noContesto,
    OpcionPregunta.noContesto,
    OpcionPregunta.noContesto,
  ];

  @override
  Widget build(BuildContext context) {
    final Column columnaPreguntas = Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        preguntas.length,
        (index) => CustomTableCellText(
          label: preguntas[index],
          height: 75,
        ),
      ),
    );

    columnaPreguntas.children.insert(
      0,
      const CustomTableCell(
        height: 38,
        width: double.infinity,
      ),
    );

    return CustomCard(
      title: 'Cómo usa y comprende el niño el lenguaje',
      contentPadding: EdgeInsets.zero,
      textAlign: TextAlign.left,
      child: Row(
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
                  return const CustomTableCellText(
                    label: 'Todavía no',
                    height: 38,
                    fontWeight: FontWeight.w700,
                  );
                }
                index -= 1;
                return CustomTableCell(
                  child: Radio(
                    value: OpcionPregunta.todaviaNo,
                    groupValue: respuestas[index],
                    activeColor: const Color(0xFF002976),
                    onChanged: (opcion) {
                      if (opcion == null) return;
                      respuestas[index] = opcion;
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
                  return const CustomTableCellText(
                    label: 'De vez en cuando',
                    height: 38,
                    fontWeight: FontWeight.w700,
                  );
                }
                index -= 1;
                return CustomTableCell(
                  child: Radio(
                    value: OpcionPregunta.deVezEnCuando,
                    groupValue: respuestas[index],
                    activeColor: const Color(0xFF002976),
                    onChanged: (opcion) {
                      if (opcion == null) return;
                      respuestas[index] = opcion;
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
                  return const CustomTableCellText(
                    label: 'Muchas veces',
                    height: 38,
                    fontWeight: FontWeight.w700,
                  );
                }
                index -= 1;
                return CustomTableCell(
                  child: Radio(
                    value: OpcionPregunta.muchasVeces,
                    groupValue: respuestas[index],
                    activeColor: const Color(0xFF002976),
                    onChanged: (opcion) {
                      if (opcion == null) return;
                      respuestas[index] = opcion;
                      setState(() {});
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTableCellText extends StatelessWidget {
  const CustomTableCellText({
    super.key,
    required this.label,
    this.height,
    this.fontWeight,
  });

  final String label;
  final double? height;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
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
