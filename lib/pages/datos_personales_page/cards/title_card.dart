import 'package:flutter/material.dart';

import 'package:app_cdi/pages/datos_personales_page/widgets/custom_card.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({
    super.key,
    required this.inventario,
  });

  final String inventario;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: 'Palabras y Enunciados',
      height: 191.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Text(
              '($inventario)',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2B2B2B),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Donna Jackson - Maldonado, PhD',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Elizabeth Bates, PhD y Donna J. Thal, PhD',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
