import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InventarioButton extends StatefulWidget {
  const InventarioButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final void Function() onTap;

  @override
  State<InventarioButton> createState() => _InventarioButtonState();
}

class _InventarioButtonState extends State<InventarioButton> {
  Color buttonColor = const Color(0xFFD1AC2B);

  Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        buttonColor = lighten(buttonColor, 15);
        setState(() {});
      },
      onExit: (event) {
        buttonColor = const Color(0xFFD1AC2B);
        setState(() {});
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            color: buttonColor,
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
