import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/helpers/functions/check_password.dart';
import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/pages/widgets/toasts/success_toast.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/theme/theme.dart';

class CambiarContrasenaPopup extends StatefulWidget {
  const CambiarContrasenaPopup({Key? key}) : super(key: key);

  @override
  State<CambiarContrasenaPopup> createState() => _CambiarContrasenaPopupState();
}

class _CambiarContrasenaPopupState extends State<CambiarContrasenaPopup> {
  bool visibility1 = false;
  bool visibility2 = false;
  bool visibility3 = false;

  final formKey = GlobalKey<FormState>();
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final UserState provider = Provider.of<UserState>(context);
    return Dialog(
      insetPadding: EdgeInsets.zero,
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
          width: MediaQuery.of(context).size.width * 0.175,
          height: MediaQuery.of(context).size.height * 0.325,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: AppTheme.of(context).primaryBackground,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 1,
              color: AppTheme.of(context).primaryColor,
            ),
          ),
          alignment: Alignment.topCenter,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.175,
                height: MediaQuery.of(context).size.height * 0.325,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 25,
                        ),
                        child: Text(
                          'Cambiar Contraseña',
                          style: AppTheme.of(context).title1.override(
                                fontFamily: 'Gotham-Bold',
                                color: AppTheme.of(context).primaryColor,
                                fontSize: 30,
                                useGoogleFonts: false,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            //NOMBRE
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.contrasenaAnteriorPerfil,
                                maxLines: 1,
                                obscureText: !visibility1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La contraseña anterior es obligatoria';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  errorMaxLines: 2,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Contraseña anterior',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 132, 132),
                                    fontSize: 15,
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => visibility1 = !visibility1,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      visibility1
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color:
                                          AppTheme.themeMode == ThemeMode.light
                                              ? Colors.grey
                                              : Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //APELLIDOS
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.contrasenaPerfil,
                                maxLines: 1,
                                obscureText: !visibility2,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La contraseña es obligatoria';
                                  }
                                  return checkPassword(value);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  errorMaxLines: 6,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Nueva contraseña',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 132, 132),
                                    fontSize: 15,
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => visibility2 = !visibility2,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      visibility2
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color:
                                          AppTheme.themeMode == ThemeMode.light
                                              ? Colors.grey
                                              : Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.confirmarContrasenaPerfil,
                                maxLines: 1,
                                obscureText: !visibility3,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'La contraseña de confirmación es obligatoria';
                                  }
                                  if (provider.confirmarContrasenaPerfil.text !=
                                      provider.contrasenaPerfil.text) {
                                    return 'La contraseña no coincide';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  errorMaxLines: 2,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Confirmar contraseña',
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 135, 132, 132),
                                    fontSize: 15,
                                  ),
                                  focusColor: Colors.black,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppTheme.of(context).primaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => setState(
                                      () => visibility3 = !visibility3,
                                    ),
                                    focusNode: FocusNode(skipTraversal: true),
                                    child: Icon(
                                      visibility3
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color:
                                          AppTheme.themeMode == ThemeMode.light
                                              ? Colors.grey
                                              : Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      AnimatedHoverButton(
                        icon: Icons.save,
                        tooltip: 'Guardar',
                        primaryColor: AppTheme.of(context).primaryColor,
                        secondaryColor: AppTheme.of(context).primaryBackground,
                        onTap: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final res = await provider.actualizarContrasena();
                          if (!res) {
                            await ApiErrorHandler.callToast(
                              'Error al actualizar contraseña',
                            );
                            return;
                          }
                          if (!mounted) return;
                          fToast.showToast(
                            child: const SuccessToast(
                              message: 'Contraseña actualizada',
                            ),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: const Duration(seconds: 2),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 8,
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
            ],
          ),
        ),
      ),
    );
  }
}
