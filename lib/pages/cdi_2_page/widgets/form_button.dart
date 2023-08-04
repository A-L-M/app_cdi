import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormButton extends StatefulWidget {
  const FormButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    this.fontSize = 14,
  }) : super(key: key);

  final String label;
  final void Function() onTap;
  final EdgeInsets padding;
  final double fontSize;

  @override
  State<FormButton> createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<FormButton> {
  Color buttonColor = const Color(0xFFD1AC2B);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onTap,
      color: buttonColor,
      child: Container(
        padding: widget.padding,
        child: Text(
          widget.label,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
