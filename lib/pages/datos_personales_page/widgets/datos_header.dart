import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatosHeader extends StatelessWidget {
  const DatosHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1140,
      height: 277.04,
      decoration: const BoxDecoration(
        color: Color(0x00333333),
      ),
      child: Container(
        width: 1020,
        height: 151.04,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 60),
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: const Color(0xFF002976),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'CDI',
                style: GoogleFonts.montserrat(
                  fontSize: 63,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                'Inventario MacArthur-Bates del Desarrollo de Habilidades Comunicativas',
                style: GoogleFonts.robotoSlab(
                  fontSize: 21,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
