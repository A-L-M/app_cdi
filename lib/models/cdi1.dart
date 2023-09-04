import 'dart:convert';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/models/models.dart';

class CDI1 {
  CDI1({
    required this.cdi1Id,
    required this.bebeId,
    required this.nombreBebe,
    required this.createdAt,
    required this.palabras,
    required this.parte1,
    required this.parte2,
  });

  int cdi1Id;
  int bebeId;
  String nombreBebe;
  DateTime createdAt;
  List<PalabraCDI1Valor> palabras;
  CDI1Parte1 parte1;
  CDI1Parte2 parte2;

  factory CDI1.fromJson(String str) => CDI1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDI1.fromMap(Map<String, dynamic> json) {
    return CDI1(
      cdi1Id: json['cdi1_id'],
      bebeId: json['bebe_id'],
      nombreBebe: json['nombre_bebe'],
      createdAt: DateTime.parse(json['created_at']),
      palabras: json['palabras'] != null
          ? (json['palabras'] as List)
              .map((palabra) => PalabraCDI1Valor.fromJson(jsonEncode(palabra)))
              .toList()
          : [],
      parte1: CDI1Parte1.fromJson(jsonEncode(json)),
      parte2: CDI1Parte2.fromJson(jsonEncode(json)),
    );
  }

  Map<String, dynamic> toMap() => {
        'cdi1_id': cdi1Id,
        'bebe_id': bebeId,
        'nombre_bebe': nombreBebe,
        'created_at': createdAt.parseToString('yyyy-MM-dd'),
      };
}
