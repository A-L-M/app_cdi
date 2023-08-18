import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/widgets/animated_hover_button.dart';
import 'package:app_cdi/pages/widgets/toasts/success_toast.dart';
import 'package:app_cdi/pages/widgets/top_menu/editar_perfil_popup/cambiar_contrasena_popup.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/theme/theme.dart';

class EditarPerfilPopup extends StatefulWidget {
  const EditarPerfilPopup({Key? key}) : super(key: key);

  @override
  State<EditarPerfilPopup> createState() => _EditarPerfilPopupState();
}

class _EditarPerfilPopupState extends State<EditarPerfilPopup> {
  final formKey = GlobalKey<FormState>();
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    final UserState provider = Provider.of<UserState>(context);
    fToast.init(context);
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
          height: MediaQuery.of(context).size.height * 0.64,
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
                height: MediaQuery.of(context).size.height * 0.64,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 25,
                        ),
                        child: Text(
                          'Perfil de Usuario',
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
                                controller: provider.nombrePerfil,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El nombre es obligatorio';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Nombre',
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
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //APELLIDOS
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.apellidosPerfil,
                                maxLines: 1,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Los apellidos son obligatorios';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Apellidos',
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
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //CORREO
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.emailPerfil,
                                maxLines: 1,
                                readOnly: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Correo',
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
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            //TELEFONO
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: provider.telefonoPerfil,
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'),
                                  )
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'El teléfono es obligatorio';
                                  }
                                  if (value.length != 10) {
                                    return 'El teléfono debe tener 10 dígitos';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      AppTheme.of(context).primaryBackground,
                                  labelText: 'Teléfono',
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
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      //LINK CAMBIAR CONTRASENA
                      const SizedBox(height: 10),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return const CambiarContrasenaPopup();
                              },
                            );
                          },
                          child: Text(
                            'Cambiar contraseña',
                            style: AppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Gotham-Regular',
                                  color: AppTheme.of(context).primaryColor,
                                  decoration: TextDecoration.underline,
                                  useGoogleFonts: false,
                                ),
                          ),
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

                          //Editar perfil de usuario
                          bool res = await provider.editarPerfilDeUsuario();

                          if (!res) {
                            await ApiErrorHandler.callToast(
                                'Error al editar perfil de usuario');
                            return;
                          }

                          //Si algun paso falla => rollback

                          if (!mounted) return;
                          fToast.showToast(
                            child: const SuccessToast(
                              message: 'Perfil editado',
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
                right: 10,
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
