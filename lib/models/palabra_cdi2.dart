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

class PalabraCDI2Valor {
  PalabraCDI2Valor({
    required this.palabraId,
    required this.seccionFk,
    required this.opcion,
  });

  int palabraId;
  int seccionFk;
  Opcion opcion;

  factory PalabraCDI2Valor.fromJson(String str) =>
      PalabraCDI2Valor.fromMap(json.decode(str));

  factory PalabraCDI2Valor.fromMap(Map<String, dynamic> json) =>
      PalabraCDI2Valor(
        palabraId: json['palabra_cdi2_inventario_id'],
        seccionFk: json['seccion_fk'],
        opcion: PalabraCDI2.convertToEnum(json['valor']),
      );
}
