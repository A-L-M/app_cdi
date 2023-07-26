import 'dart:convert';

enum Opcion { comprende, comprendeYDice, noContesto }

class PalabraCDI2 {
  PalabraCDI2({
    required this.palabraId,
    required this.nombre,
    required this.sombreada,
    required this.subrayada,
  });

  int palabraId;
  String nombre;
  bool sombreada;
  bool subrayada;
  Opcion? opcion;

  factory PalabraCDI2.fromJson(String str) =>
      PalabraCDI2.fromMap(json.decode(str));

  factory PalabraCDI2.fromMap(Map<String, dynamic> json) => PalabraCDI2(
        palabraId: json['palabra_cdi2_inventario_id'],
        nombre: json["nombre"],
        sombreada: json['sombreada'],
        subrayada: json['subrayada'],
      );
}
