import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DatosInputField extends StatefulWidget {
  const DatosInputField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.unfocusedTextColor = const Color(0xFFBfbfbf),
    required this.textInputType,
    required this.inputFormatters,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color unfocusedTextColor;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<DatosInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<DatosInputField> {
  late Color currentTextColor;

  @override
  void initState() {
    currentTextColor = widget.unfocusedTextColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        key: widget.key,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          contentPadding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 15,
            bottom: 12.5,
          ),
          alignLabelWithHint: true,
          hintText: widget.label,
          hintStyle: GoogleFonts.robotoSlab(
            color: currentTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFCCCCCC),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.88),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.88),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.88),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4.88),
          ),
          focusColor: AppTheme.of(context).primaryColor,
        ),
        style: GoogleFonts.robotoSlab(
          color: const Color(0xFF2B2B2B),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
