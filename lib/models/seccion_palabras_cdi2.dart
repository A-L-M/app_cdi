import 'dart:convert';
import 'dart:developer';

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

  void setPalabra(int id, Opcion opcion) {
    try {
      int index = palabras.indexWhere((element) => element.palabraId == id);
      palabras[index].opcion = opcion;
    } catch (e) {
      log('Error en setPalabra() - $e');
    }
  }

  void asignarValores(List<PalabraCDI2Valor> valores) {
    for (var palabra in palabras) {
      final index = valores.indexWhere((valor) => valor.palabraId == palabra.palabraId);
      if (index == -1) {
        palabra.opcion = Opcion.ninguna;
      } else {
        palabra.opcion = valores[index].opcion;
      }
    }
  }

  int getTotalComprende() {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprende) total += 1;
    }
    return total;
  }

  int getTotalComprendeYDice() {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprendeYDice) total += 1;
    }
    return total;
  }

  int getTotalComprendeICPLIM() {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprende && palabra.subrayada) total += 1;
    }
    return total;
  }

  int getTotalComprendeYDiceICPLIM() {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprendeYDice && palabra.subrayada) total += 1;
    }
    return total;
  }

  factory SeccionPalabrasCDI2.fromJson(String str) => SeccionPalabrasCDI2.fromMap(json.decode(str));

  factory SeccionPalabrasCDI2.fromMap(Map<String, dynamic> json) => SeccionPalabrasCDI2(
        seccionId: json['seccion_palabras_cdi2_id'],
        nombre: json["nombre"],
        palabras: (json['palabras'] as List).map((palabra) => PalabraCDI2.fromMap(palabra)).toList(),
      );
}
