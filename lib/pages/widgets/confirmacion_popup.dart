import 'package:flutter/material.dart';

import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:go_router/go_router.dart';

class ConfirmacionPopup extends StatelessWidget {
  const ConfirmacionPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          width: MediaQuery.of(context).size.width * 0.35,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: AppTheme.of(context).primaryColor,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: AppTheme.of(context).primaryColor,
                    size: 24,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 25,
                    ),
                    child: Text(
                      '¿Estás seguro que deseas borrar este registro?',
                      style: AppTheme.of(context).title2,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedHoverButton(
                        icon: Icons.check,
                        tooltip: 'Aceptar',
                        primaryColor: AppTheme.of(context).primaryColor,
                        secondaryColor: AppTheme.of(context).primaryBackground,
                        onTap: () {
                          context.pop(true);
                        },
                      ),
                      const SizedBox(width: 20),
                      AnimatedHoverButton(
                        icon: Icons.close,
                        tooltip: 'Cancelar',
                        primaryColor: Colors.grey,
                        secondaryColor: AppTheme.of(context).primaryBackground,
                        onTap: () {
                          context.pop(false);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
