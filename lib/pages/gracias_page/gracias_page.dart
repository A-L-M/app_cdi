import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GraciasPage extends StatelessWidget {
  const GraciasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              color: Colors.greenAccent,
              size: 75,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                '¡Gracias por contestar!',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.robotoSlab(
                  fontSize: 21,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
