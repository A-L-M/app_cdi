import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncisoCWidget extends StatefulWidget {
  const IncisoCWidget({super.key});

  @override
  State<IncisoCWidget> createState() => _IncisoCWidgetState();
}

class _IncisoCWidgetState extends State<IncisoCWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'C. Complejidad de frases',
      child: Column(
        children: [
          Text(
            'A continuación encontrará pares de frases. Por favor, señale la que más se parezca a la forma como habla su hijo(a) en este momento. Si su hijo(a) usa frases más largas o complicadas de las que vienen en los ejemplos, por favor marque la segunda frase. El (la) niño(a) no tiene que decir exactamente la misma frase; lo que le pedimos es que marque la frase que se parezca más a la manera en que su hijo(a) habla.',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
