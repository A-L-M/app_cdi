import 'dart:convert';

enum Opcion { comprende, comprendeYDice, ninguna, dejoDeContestar }

class PalabraCDI2 {
  PalabraCDI2({
    required this.palabraId,
    required this.nombre,
    required this.sombreada,
    required this.subrayada,
    this.opcion = Opcion.ninguna,
  });

  int palabraId;
  String nombre;
  bool sombreada;
  bool subrayada;
  Opcion opcion;

  factory PalabraCDI2.fromJson(String str) =>
      PalabraCDI2.fromMap(json.decode(str));

  factory PalabraCDI2.fromMap(Map<String, dynamic> json) => PalabraCDI2(
        palabraId: json['palabra_cdi2_inventario_id'],
        nombre: json["nombre"],
        sombreada: json['sombreada'],
        subrayada: json['subrayada'],
        opcion: convertToEnum(json['valor']),
      );

  static int convertToInt(Opcion? value) {
    switch (value) {
      case Opcion.comprende:
        return 1;
      case Opcion.comprendeYDice:
        return 2;
      case Opcion.ninguna:
        return 0;
      case Opcion.dejoDeContestar:
        return 9;
      default:
        return 3;
    }
  }

  static Opcion convertToEnum(int? value) {
    switch (value) {
      case 1:
        return Opcion.comprende;
      case 2:
        return Opcion.comprendeYDice;
      case 0:
        return Opcion.ninguna;
      case 9:
        return Opcion.dejoDeContestar;
      default:
        return Opcion.ninguna;
    }
  }
}
