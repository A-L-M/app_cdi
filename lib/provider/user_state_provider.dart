import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/router/router.dart';
import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  //EMAIL
  String _email = '';

  String get email => _email;
  Future<void> setEmail() async {
    _email = emailController.text;
    await prefs.setString('email', emailController.text);
  }

  //Controlador para LoginScreen
  TextEditingController emailController = TextEditingController();

  //PASSWORD
  String _password = '';

  String get password => _password;
  Future<void> setPassword() async {
    _password = passwordController.text;
    await prefs.setString('password', passwordController.text);
  }

  //Controlador para LoginScreen
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  //Variables para editar perfil
  TextEditingController nombrePerfil = TextEditingController();
  TextEditingController apellidosPerfil = TextEditingController();
  TextEditingController telefonoPerfil = TextEditingController();
  TextEditingController emailPerfil = TextEditingController();
  TextEditingController contrasenaAnteriorPerfil = TextEditingController();
  TextEditingController confirmarContrasenaPerfil = TextEditingController();
  TextEditingController contrasenaPerfil = TextEditingController();

  //Constructor de provider
  UserState() {
    rememberMe = prefs.getBool('recuerdame') ?? false;

    if (rememberMe == true) {
      _email = prefs.getString('email') ?? _email;
      _password = prefs.getString('password') ?? password;
    }

    emailController.text = _email;
    passwordController.text = _password;
  }

  Future<bool> actualizarContrasena() async {
    try {
      final res = await supabase.rpc('change_user_password', params: {
        'current_plain_password': contrasenaAnteriorPerfil.text,
        'new_plain_password': contrasenaPerfil.text,
      });
      if (res == null) {
        log('Error en actualizarContrasena()');
        return false;
      }
      return true;
    } catch (e) {
      log('Error en actualizarContrasena() - $e');
      return false;
    }
  }

  void initPerfilUsuario() {
    if (currentUser == null) return;
    nombrePerfil.text = currentUser!.nombre;
    apellidosPerfil.text = currentUser!.apellidos;
    telefonoPerfil.text = currentUser!.telefono ?? '';
    emailPerfil.text = currentUser!.email;
    contrasenaPerfil.clear();
    contrasenaAnteriorPerfil.clear();
    confirmarContrasenaPerfil.clear();
  }

  Future<bool> editarPerfilDeUsuario() async {
    try {
      await supabase.from('perfil_usuario').update(
        {
          'nombre': nombrePerfil.text,
          'apellidos': apellidosPerfil.text,
          'telefono': telefonoPerfil.text,
        },
      ).eq('perfil_usuario_id', currentUser!.id);
      return true;
    } catch (e) {
      log('Error en editarPerfilDeUsuario() - $e');
      return false;
    }
  }

  Future<String?> getUserId(String email) async {
    try {
      final res = await supabase.from('users').select('id').eq('email', email);
      if ((res as List).isNotEmpty || res[0]['id'] != null) {
        return res[0]['id'];
      }
      return null;
    } catch (e) {
      log('Error en getUserId - $e');
      return null;
    }
  }

  Future<void> updateRecuerdame() async {
    rememberMe = !rememberMe;
    await prefs.setBool('recuerdame', rememberMe);
    notifyListeners();
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    currentUser = null;
    await prefs.remove('currentPais');
    await prefs.remove('currentRol');
    router.pushReplacement('/');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    nombrePerfil.dispose();
    emailPerfil.dispose();
    contrasenaPerfil.dispose();
    super.dispose();
  }
}
