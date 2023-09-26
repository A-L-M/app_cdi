import 'dart:convert';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/models/models.dart';

class CDI2 {
  CDI2({
    required this.cdi2Id,
    required this.bebeId,
    required this.nombreBebe,
    required this.fechaNacimiento,
    required this.createdAt,
    required this.palabras,
    required this.comprension,
    required this.parte2,
  });

  int cdi2Id;
  int bebeId;
  String nombreBebe;
  DateTime fechaNacimiento;
  DateTime createdAt;
  List<PalabraCDI2Valor> palabras;
  CDI2Comprension comprension;
  CDI2Parte2 parte2;

  int get edad => createdAt.difference(fechaNacimiento).inDays ~/ 30;

  factory CDI2.fromJson(String str) => CDI2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDI2.fromMap(Map<String, dynamic> json) {
    return CDI2(
      cdi2Id: json['cdi2_id'],
      bebeId: json['bebe_id'],
      nombreBebe: json['nombre_bebe'],
      createdAt: DateTime.parse(json['created_at']),
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento']),
      palabras: json['palabras'] != null
          ? (json['palabras'] as List).map((palabra) => PalabraCDI2Valor.fromJson(jsonEncode(palabra))).toList()
          : [],
      comprension: CDI2Comprension.fromJson(jsonEncode(json)),
      parte2: CDI2Parte2.fromJson(jsonEncode(json)),
    );
  }

  Map<String, dynamic> toMap() => {
        'cdi2_id': cdi2Id,
        'bebe_id': bebeId,
        'nombre_bebe': nombreBebe,
        'created_at': createdAt.parseToString('yyyy-MM-dd'),
      };
}
