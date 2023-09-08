import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncisoDWidget extends StatefulWidget {
  const IncisoDWidget({super.key});

  @override
  State<IncisoDWidget> createState() => _IncisoDWidgetState();
}

class _IncisoDWidgetState extends State<IncisoDWidget> {
  final List<String> preguntas = [
    '1. Acostarlo.',
    '2. Taparlo con la cobija.',
    '3. Darle su botella.',
    '4. Darle de comer con una cuchara.',
    '5. Peinarlo.',
    '6. Sacarle el aire con palmaditas en la espalda.',
    '7. Empujarlo en un carrito.',
    '8. Mecerlo o arrullarlo',
    '9. Darle besitos.',
    '10. Tratar de vestirlo.',
    '11. Limpiarle la cara.',
    '12. Hablarle.',
    '13. Tratar de ponerle un pañal.',
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

    var respuestas = provider.parte2.listaJuegos;

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
                    provider.setJuegosIncisoD(opcion, index);
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
                    provider.setJuegosIncisoD(opcion, index);
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
      title: 'D. Jugar a ser adulto',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Muchas veces, los niños juegan con sus muñecos a hacer cosas que hacen los adultos. Si ha visto a su hijo(a) hacer algunas de las siguientes actividades, por favor indíquelo.',
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
