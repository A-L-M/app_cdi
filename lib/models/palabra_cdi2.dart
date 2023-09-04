import 'dart:convert';

import 'package:app_cdi/models/enums.dart';

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
        opcion: convertToEnumOpcion(json['valor']),
      );
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
        opcion: convertToEnumOpcion(json['valor']),
      );
}
