import 'dart:convert';

import 'package:app_cdi/helpers/datetime_extension.dart';

class CDI2 {
  CDI2({
    required this.cdi2Id,
    required this.bebeId,
    required this.nombreBebe,
    required this.createdAt,
  });

  int cdi2Id;
  int bebeId;
  String nombreBebe;
  DateTime createdAt;

  factory CDI2.fromJson(String str) => CDI2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDI2.fromMap(Map<String, dynamic> json) {
    return CDI2(
      cdi2Id: json['cdi2_id'],
      bebeId: json['bebe_id'],
      nombreBebe: json['nombre_bebe'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toMap() => {
        'cdi2_id': cdi2Id,
        'bebe_id': bebeId,
        'nombre_bebe': nombreBebe,
        'created_at': createdAt.parseToString('yyyy-MM-dd'),
      };
}
