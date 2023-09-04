import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/models/models.dart';

class SeccionPalabrasCDI1 {
  SeccionPalabrasCDI1({
    required this.seccionId,
    required this.nombre,
    required this.palabras,
  });

  int seccionId;
  String nombre;
  List<PalabraCDI1> palabras;

  String get tituloCompleto => '$seccionId.- $nombre';

  void setPalabra(int id, Opcion opcion) {
    try {
      int index = palabras.indexWhere((element) => element.palabraId == id);
      palabras[index].opcion = opcion;
    } catch (e) {
      log('Error en setPalabra() - $e');
    }
  }

  factory SeccionPalabrasCDI1.fromJson(String str) =>
      SeccionPalabrasCDI1.fromMap(json.decode(str));

  factory SeccionPalabrasCDI1.fromMap(Map<String, dynamic> json) =>
      SeccionPalabrasCDI1(
        seccionId: json['seccion_palabras_cdi1_id'],
        nombre: json["nombre"],
        palabras: (json['palabras'] as List)
            .map((palabra) => PalabraCDI1.fromJson(jsonEncode(palabra)))
            .toList(),
      );
}
