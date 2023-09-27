import 'dart:convert';

class Rol {
  Rol({
    required this.rolId,
    required this.nombre,
    required this.permisos,
  });

  int rolId;
  String nombre;
  Permisos permisos;

  factory Rol.fromJson(String str) => Rol.fromMap(json.decode(str));

  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        rolId: json['rol_id'],
        nombre: json["nombre"],
        permisos: Permisos.fromMap(json["permisos"]),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Rol && other.nombre == nombre && other.rolId == rolId;
  }

  @override
  int get hashCode => Object.hash(rolId, nombre, permisos);
}

class Permisos {
  Permisos({
    required this.administracionBebes,
    required this.administracionCDI1,
    required this.administracionCDI2,
    required this.administracionDeUsuarios,
  });

  String? administracionBebes;
  String? administracionCDI1;
  String? administracionCDI2;
  String? administracionDeUsuarios;

  factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

  factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        administracionBebes: json["Administración de Bebés"],
        administracionCDI1: json["CDI 1"],
        administracionCDI2: json["CDI 2"],
        administracionDeUsuarios: json["Administración de Usuarios"],
      );
}
