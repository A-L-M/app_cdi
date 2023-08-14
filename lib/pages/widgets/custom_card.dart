import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.child,
    this.width = double.infinity,
    this.contentPadding = const EdgeInsets.all(15),
    this.textAlign = Alignment.center,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double width;
  final EdgeInsets contentPadding;
  final Alignment textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: width,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: const BoxDecoration(
              color: Color(0xFF002976),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: SizedBox(
              height: size.width > 857 ? 17.6 : 36,
              child: Align(
                alignment: textAlign,
                child: Text(
                  title.toUpperCase(),
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: textAlign == Alignment.center
                      ? TextAlign.center
                      : TextAlign.start,
                ),
              ),
            ),
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                padding: contentPadding,
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
