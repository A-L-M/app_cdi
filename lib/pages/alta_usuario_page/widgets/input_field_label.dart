import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';

class InputFieldLabel extends StatelessWidget {
  const InputFieldLabel({
    Key? key,
    required this.label,
    this.seleccionado = false,
  }) : super(key: key);

  final String label;
  final bool seleccionado;

  @override
  Widget build(BuildContext context) {
    if (seleccionado) {
      return const SizedBox.shrink();
    } else {
      return Positioned(
        top: 15,
        child: RichText(
          text: TextSpan(
            text: '  $label ',
            style: AppTheme.of(context).bodyText2,
            children: [
              TextSpan(
                text: '*',
                style: AppTheme.of(context).bodyText2.override(
                      fontFamily: 'Gotham-Regular',
                      color: AppTheme.of(context).primaryColor,
                      useGoogleFonts: false,
                    ),
              )
            ],
          ),
        ),
      );
    }
  }
}
