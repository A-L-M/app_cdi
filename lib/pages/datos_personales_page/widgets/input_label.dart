import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputLabel extends StatelessWidget {
  const InputLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Text(
        label,
        style: GoogleFonts.robotoSlab(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF2B2B2B),
        ),
      ),
    );
  }
}
