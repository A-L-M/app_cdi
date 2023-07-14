import 'dart:convert';

import 'package:app_cdi/models/models.dart';

class SeccionPalabrasCDI2 {
  SeccionPalabrasCDI2({
    required this.seccionId,
    required this.nombre,
    required this.palabras,
  });

  int seccionId;
  String nombre;
  List<PalabraCDI2> palabras;

  String get tituloCompleto => '$seccionId.- $nombre';

  factory SeccionPalabrasCDI2.fromJson(String str) =>
      SeccionPalabrasCDI2.fromMap(json.decode(str));

  factory SeccionPalabrasCDI2.fromMap(Map<String, dynamic> json) =>
      SeccionPalabrasCDI2(
        seccionId: json['seccion_palabras_cdi2_id'],
        nombre: json["nombre"],
        palabras: (json['palabras'] as List)
            .map((palabra) => PalabraCDI2.fromJson(jsonEncode(palabra)))
            .toList(),
      );
}
