import 'dart:convert';

import 'package:app_cdi/models/models.dart';

class CDI1Parte2 {
  CDI1Parte2({
    required this.cdi1Id,
    required this.listaGestos,
    required this.listaRutinas,
    required this.listaAcciones,
    required this.listaJuegos,
    required this.listaImitaciones,
  });

  int? cdi1Id;
  List<RespuestaComprension> listaGestos = []; //A
  List<bool?> listaRutinas = []; //B
  List<bool?> listaAcciones = []; //C
  List<bool?> listaJuegos = []; //D
  List<bool?> listaImitaciones = []; //E

  int get totalGestos {
    int total = 0;
    for (RespuestaComprension element in listaGestos) {
      if (element == RespuestaComprension.deVezEnCuando || element == RespuestaComprension.muchasVeces) total += 1;
    }
    for (var element in listaRutinas) {
      if (element == true) total += 1;
    }
    for (var element in listaAcciones) {
      if (element == true) total += 1;
    }
    for (var element in listaJuegos) {
      if (element == true) total += 1;
    }
    for (var element in listaImitaciones) {
      if (element == true) total += 1;
    }
    return total;
  }

  int get gestosTempranos {
    int total = 0;
    for (RespuestaComprension element in listaGestos) {
      if (element == RespuestaComprension.deVezEnCuando || element == RespuestaComprension.muchasVeces) total += 1;
    }
    for (var element in listaRutinas) {
      if (element == true) total += 1;
    }
    return total;
  }

  int get gestosTardios {
    int total = 0;
    for (var element in listaAcciones) {
      if (element == true) total += 1;
    }
    for (var element in listaJuegos) {
      if (element == true) total += 1;
    }
    for (var element in listaImitaciones) {
      if (element == true) total += 1;
    }
    return total;
  }

  factory CDI1Parte2.fromJson(String str) => CDI1Parte2.fromMap(json.decode(str));

  factory CDI1Parte2.fromMap(Map<String, dynamic> json) {
    final List<RespuestaComprension> listaGestosTemp = [];

    for (var i = 1; i <= 13; i++) {
      listaGestosTemp.add(convertToEnum(json['gesto$i']));
    }

    final List<bool?> listaRutinasTemp = [];

    for (var i = 1; i <= 8; i++) {
      listaRutinasTemp.add(json['rutinas$i']);
    }

    final List<bool?> listaAccionesTemp = [];

    for (var i = 1; i <= 15; i++) {
      listaAccionesTemp.add(json['acciones$i']);
    }

    final List<bool?> listaJuegosTemp = [];

    for (var i = 1; i <= 13; i++) {
      listaJuegosTemp.add(json['juegos$i']);
    }

    final List<bool?> listaImitacionesTemp = [];

    for (var i = 1; i <= 15; i++) {
      listaImitacionesTemp.add(json['imitacion$i']);
    }

    return CDI1Parte2(
      cdi1Id: json['cdi1_id'],
      listaGestos: listaGestosTemp,
      listaRutinas: listaRutinasTemp,
      listaAcciones: listaAccionesTemp,
      listaJuegos: listaJuegosTemp,
      listaImitaciones: listaImitacionesTemp,
    );
  }
}
