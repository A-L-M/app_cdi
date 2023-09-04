import 'dart:convert';

import 'package:app_cdi/models/models.dart';

class PalabraCDI1 {
  PalabraCDI1({
    required this.palabraId,
    required this.nombre,
    this.opcion = Opcion.ninguna,
  });

  int palabraId;
  String nombre;
  Opcion opcion;

  factory PalabraCDI1.fromJson(String str) =>
      PalabraCDI1.fromMap(json.decode(str));

  factory PalabraCDI1.fromMap(Map<String, dynamic> json) => PalabraCDI1(
        palabraId: json['palabra_cdi1_inventario_id'],
        nombre: json["nombre"],
        opcion: convertToEnumOpcion(json['valor']),
      );
}

class PalabraCDI1Valor {
  PalabraCDI1Valor({
    required this.palabraId,
    required this.seccionFk,
    required this.opcion,
  });

  int palabraId;
  int seccionFk;
  Opcion opcion;

  factory PalabraCDI1Valor.fromJson(String str) =>
      PalabraCDI1Valor.fromMap(json.decode(str));

  factory PalabraCDI1Valor.fromMap(Map<String, dynamic> json) =>
      PalabraCDI1Valor(
        palabraId: json['palabra_cdi1_inventario_id'],
        seccionFk: json['seccion_fk'],
        opcion: convertToEnumOpcion(json['valor']),
      );
}
