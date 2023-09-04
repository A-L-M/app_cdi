import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  const Popup({
    super.key,
    required this.child,
    this.width,
  });

  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: width ?? size.width * 0.35,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: AppTheme.of(context).primaryColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
