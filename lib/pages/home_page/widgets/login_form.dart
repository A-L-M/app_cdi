import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/helpers/supabase/queries.dart';
import 'package:app_cdi/pages/home_page/widgets/inventario_button.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/provider/user_state_provider.dart';
import 'package:app_cdi/theme/theme.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Container(
      height: 230,
      width: 250,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xCCFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LoginInputField(
              label: 'Usuario',
              controller: userState.emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El correo es obligatorio';
                } else if (!EmailValidator.validate(value)) {
                  return 'Por favor ingresa un correo válido';
                }
                return null;
              },
            ),
            LoginInputField(
              label: 'Contraseña',
              isPasswordField: true,
              controller: userState.passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La contraseña es obligatoria';
                }
                return null;
              },
            ),
            HomePageButton(
              label: 'INICIAR SESIÓN',
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              fontSize: 14,
              onTap: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                //Login
                try {
                  await supabase.auth.signInWithPassword(
                    email: userState.emailController.text,
                    password: userState.passwordController.text,
                  );

                  if (userState.rememberMe == true) {
                    await userState.setEmail();
                    await userState.setPassword();
                  } else {
                    userState.emailController.text = '';
                    userState.passwordController.text = '';
                    await prefs.remove('email');
                    await prefs.remove('password');
                  }

                  if (supabase.auth.currentUser == null) {
                    await ApiErrorHandler.callToast();
                    return;
                  }

                  currentUser = await SupabaseQueries.getCurrentUserData();

                  if (currentUser == null) {
                    await ApiErrorHandler.callToast();
                    return;
                  }

                  print('Sesion iniciada');

                  // if (!mounted) return;
                  // context.pushReplacement('/dashboards');
                } catch (e) {
                  if (e is AuthException) {
                    await ApiErrorHandler.callToast('Credenciales inválidas');
                    return;
                  }
                  log('Error al iniciar sesión - $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LoginInputField extends StatefulWidget {
  const LoginInputField({
    Key? key,
    required this.label,
    this.isPasswordField = false,
    required this.controller,
    this.validator,
    this.unfocusedTextColor = Colors.black,
  }) : super(key: key);

  final String label;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Color unfocusedTextColor;

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  bool passwordVisibility = false;

  late Color currentTextColor;

  @override
  void initState() {
    currentTextColor = widget.unfocusedTextColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        key: widget.key,
        controller: widget.controller,
        obscureText: widget.isPasswordField ? !passwordVisibility : false,
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
          labelText: widget.label,
          labelStyle: GoogleFonts.poppins(
            color: currentTextColor,
            fontWeight: FontWeight.normal,
          ),
          alignLabelWithHint: true,
          hintText: widget.label,
          hintStyle: GoogleFonts.poppins(
            color: currentTextColor,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 0.4,
            ),
            borderRadius: BorderRadius.circular(4.88),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
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
          focusColor: AppTheme.of(context).primaryColor,
          prefixIcon: widget.isPasswordField
              ? const Icon(Icons.key_sharp)
              : const Icon(Icons.person_2_outlined),
          prefixIconColor: Colors.black,
          suffixIcon: widget.isPasswordField
              ? InkWell(
                  onTap: () => setState(
                    () => passwordVisibility = !passwordVisibility,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    passwordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.black,
                    size: 22,
                  ),
                )
              : null,
        ),
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 15.6,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
