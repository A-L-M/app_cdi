import 'dart:convert';

import 'package:app_cdi/models/models.dart';

class Usuario {
  Usuario({
    required this.id,
    required this.idSecuencial,
    required this.email,
    required this.nombre,
    required this.apellidos,
    this.imagen,
    this.telefono,
    required this.rol,
  });

  String id;
  int idSecuencial;
  String email;
  String nombre;
  String apellidos;
  String? imagen;
  String? telefono;
  Rol rol;

  String get nombreCompleto => '$nombre $apellidos';

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  factory Usuario.fromMap(Map<String, dynamic> json) {
    Usuario usuario = Usuario(
      id: json["id"],
      idSecuencial: json["id_secuencial"],
      email: json["email"],
      nombre: json["nombre"],
      apellidos: json["apellidos"],
      imagen: json['imagen'],
      telefono: json["telefono"],
      rol: Rol.fromJson(jsonEncode(json['rol'])),
    );
    return usuario;
  }
}
