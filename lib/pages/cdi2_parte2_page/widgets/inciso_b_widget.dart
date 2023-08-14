import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/cdi_2_provider.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncisoBWidget extends StatefulWidget {
  const IncisoBWidget({super.key});

  @override
  State<IncisoBWidget> createState() => _IncisoBWidgetState();
}

class _IncisoBWidgetState extends State<IncisoBWidget> {
  @override
  Widget build(BuildContext context) {
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);
    return CustomCard(
      title: 'B. Ejemplos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Por favor escriba tres ejemplos de las frases más largas que recuerde que su hijo(a) haya dicho últimamente.',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          //TODO: actualizar modelo parte2
          EjemploTextField(
            label: '1.-',
            controller: provider.ejemplo1Controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El valor es requerido';
              }
              return null;
            },
          ),
          EjemploTextField(
            label: '2.-',
            controller: provider.ejemplo2Controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El valor es requerido';
              }
              return null;
            },
          ),
          EjemploTextField(
            label: '3.-',
            controller: provider.ejemplo3Controller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'El valor es requerido';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class EjemploTextField extends StatefulWidget {
  const EjemploTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.unfocusedTextColor = Colors.grey,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color unfocusedTextColor;

  @override
  State<EjemploTextField> createState() => _EjemploTextFieldState();
}

class _EjemploTextFieldState extends State<EjemploTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        height: 50,
        child: FocusScope(
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
                bottom: 15,
              ),
              labelText: widget.label,
              labelStyle: AppTheme.of(context).bodyText2,
              alignLabelWithHint: true,
              hintText: widget.label,
              hintStyle: AppTheme.of(context).bodyText2,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).secondaryColor,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppTheme.of(context).secondaryColor,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.4,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusColor: AppTheme.of(context).secondaryColor,
            ),
            style: AppTheme.of(context).bodyText2,
          ),
        ),
      ),
    );
  }
}
