import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_password_generator/random_password_generator.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

class UsuariosProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  //ALTA USUARIO
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  String? cuentasDropValue = '';

  List<Rol> roles = [];
  List<Usuario> usuarios = [];

  Rol? rolSeleccionado;

  //EDITAR USUARIOS
  Usuario? usuarioEditado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "id_secuencial";

  Future<void> updateState() async {
    await getRoles(notify: false);
    await getUsuarios();
  }

  void clearControllers({bool clearEmail = true, bool notify = true}) {
    nombreController.clear();
    if (clearEmail) correoController.clear();
    apellidosController.clear();
    telefonoController.clear();
    rolSeleccionado = null;

    if (notify) notifyListeners();
  }

  Future<void> setRolSeleccionado(String rol) async {
    rolSeleccionado = roles.firstWhere((element) => element.nombre == rol);
    notifyListeners();
  }

  Future<void> getRoles({bool notify = true}) async {
    if (roles.isNotEmpty) return;
    final res =
        await supabase.from('rol').select('rol_id, nombre, permisos').order(
              'nombre',
              ascending: true,
            );

    roles = (res as List<dynamic>)
        .map((rol) => Rol.fromJson(jsonEncode(rol)))
        .toList();

    if (notify) notifyListeners();
  }

  Future<void> getUsuarios() async {
    try {
      final query = supabase.from('users').select();

      final res = await query
          .like('nombre', '%${busquedaController.text}%')
          .order(orden, ascending: true);

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      usuarios = (res as List<dynamic>)
          .map((usuario) => Usuario.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (Usuario usuario in usuarios) {
        rows.add(
          PlutoRow(
            cells: {
              'id_secuencial': PlutoCell(value: usuario.idSecuencial),
              'nombre':
                  PlutoCell(value: "${usuario.nombre} ${usuario.apellidos}"),
              'rol': PlutoCell(value: usuario.rol.nombre),
              'email': PlutoCell(value: usuario.email),
              'telefono': PlutoCell(value: usuario.telefono ?? ''),
              'acciones': PlutoCell(value: usuario.id),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getUsuarios() - $e');
    }

    notifyListeners();
  }

  Future<Map<String, String>?> registrarUsuario() async {
    try {
      //Generar contrasena aleatoria
      final password = generatePassword();

      //Registrar al usuario con una contraseña temporal
      var response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/signup'),
        headers: {'Content-Type': 'application/json', 'apiKey': anonKey},
        body: json.encode(
          {
            "email": correoController.text,
            "password": password,
          },
        ),
      );
      if (response.statusCode > 204) return {'Error': 'El usuario ya existe'};

      final String? userId = jsonDecode(response.body)['user']['id'];

      if (userId == null) return {'Error': 'Error al registrar al usuario'};

      //retornar el id del usuario
      return {'userId': userId};
    } catch (e) {
      log('Error en registrarUsuario() - $e');
      return {'Error': 'Error al registrar usuario'};
    }
  }

  //TODO: agregar registros de sociedades

  Future<bool> crearPerfilDeUsuario(String userId) async {
    if (rolSeleccionado == null) {
      return false;
    }
    try {
      await supabase.from('perfil_usuario').insert(
        {
          'perfil_usuario_id': userId,
          'nombre': nombreController.text,
          'apellidos': apellidosController.text,
          'telefono': telefonoController.text,
          'rol_fk': rolSeleccionado!.rolId,
        },
      );
      return true;
    } catch (e) {
      log('Error en crearPerfilDeUsuario() - $e');
      return false;
    }
  }

  Future<bool> editarPerfilDeUsuario(String userId) async {
    try {
      await supabase.from('perfil_usuario').update(
        {
          'nombre': nombreController.text,
          'apellidos': apellidosController.text,
          'telefono': telefonoController.text,
          'rol_fk': rolSeleccionado!.rolId,
        },
      ).eq('perfil_usuario_id', userId);
      return true;
    } catch (e) {
      log('Error en editarPerfilUsuario() - $e');
      return false;
    }
  }

  Future<void> initEditarUsuario(Usuario usuario) async {
    usuarioEditado = usuario;
    nombreController.text = usuario.nombre;
    apellidosController.text = usuario.apellidos;
    correoController.text = usuario.email;
    telefonoController.text = usuario.telefono ?? '';
    rolSeleccionado = usuario.rol;
  }

  String generatePassword() {
    //Generar contrasena aleatoria
    final passwordGenerator = RandomPasswordGenerator();
    return passwordGenerator.randomPassword(
      letters: true,
      uppercase: true,
      numbers: true,
      specialChar: true,
      passwordLength: 8,
    );
  }

  @override
  void dispose() {
    busquedaController.dispose();
    nombreController.dispose();
    correoController.dispose();
    apellidosController.dispose();
    telefonoController.dispose();
    super.dispose();
  }
}
