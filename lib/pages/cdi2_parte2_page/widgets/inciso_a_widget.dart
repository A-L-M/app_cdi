import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncisoAWidget extends StatefulWidget {
  const IncisoAWidget({super.key});

  @override
  State<IncisoAWidget> createState() => _IncisoAWidgetState();
}

class _IncisoAWidgetState extends State<IncisoAWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'A. Formas de verbos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A continuación encontrará una lista de diferentes terminaciones de verbos. Indique si su hijo(a) usa palabras de la lista. En caso de que no utilice la misma palabra, pero que use la misma terminación con palabras similares, por favor, rellene el círculo de la palabra que más se le parezca. Por ejemplo, si en vez de "comes" dice "duermes" o "puedes", marque la línea de "comes"',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Para hablar de lo que sucede en el presente, ¿Cuáles de estas formas usa?',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerboWidget extends StatefulWidget {
  const _VerboWidget({Key? key, required this.verbo}) : super(key: key);

  final String verbo;

  @override
  State<_VerboWidget> createState() => __VerboWidgetState();
}

class __VerboWidgetState extends State<_VerboWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
      ),
      width: 285.75,
      height: 50,
      child: ListTile(
        title: Text(
          widget.verbo,
          style: GoogleFonts.robotoSlab(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF2B2B2B),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Radio(
            //   value: Opcion.comprende,
            //   groupValue: palabra.opcion,
            //   activeColor: const Color(0xFF002976),
            //   onChanged: (opcion) {
            //     if (opcion == null) return;
            //     provider.setOpcionPalabra(opcion, palabra);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
