import 'dart:convert';

class Rol {
  Rol({
    required this.nombre,
  });

  String nombre;

  factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

  factory Rol.fromMap(Map<String, dynamic> json) {
    return Rol(
      nombre: json['nombre'],
    );
  }
}
