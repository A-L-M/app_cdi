import 'dart:convert';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/tablas.dart';
import 'package:app_cdi/models/models.dart';

class CDI1 {
  CDI1({
    required this.cdi1Id,
    required this.bebeId,
    required this.nombreBebe,
    required this.cuidador,
    required this.fechaNacimiento,
    required this.createdAt,
    required this.palabras,
    required this.parte1,
    required this.parte2,
  });

  int cdi1Id;
  int bebeId;
  String nombreBebe;
  String cuidador;
  DateTime fechaNacimiento;
  DateTime createdAt;
  List<PalabraCDI1Valor> palabras;
  CDI1Parte1 parte1;
  CDI1Parte2 parte2;

  int get edad => createdAt.difference(fechaNacimiento).inDays ~/ 30;

  ({int natural, int percentil}) calcularPrimerasFrases() {
    int puntajeNatural = 0;
    for (var frase in parte1.listaFrases) {
      if (frase == true) puntajeNatural += 1;
    }
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.comprensionPrimerasFrasesCDI1, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularComprension() {
    int puntajeNatural = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprende || palabra.opcion == Opcion.comprendeYDice) puntajeNatural += 1;
    }
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.comprensionPalabrasCDI1, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularProduccion() {
    int puntajeNatural = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprendeYDice) puntajeNatural += 1;
    }
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.produccionPalabrasCDI1, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularTotalGestos() {
    int puntajeNatural = parte2.totalGestos;
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.totalGestosCDI1, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularGestosTempranos() {
    int puntajeNatural = parte2.gestosTempranos;
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.gestosTempranosCDI1, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularGestosTardios() {
    int puntajeNatural = parte2.gestosTardios;
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.gestosTardiosCDI1, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  factory CDI1.fromJson(String str) => CDI1.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDI1.fromMap(Map<String, dynamic> json) {
    return CDI1(
      cdi1Id: json['cdi1_id'],
      bebeId: json['bebe_id'],
      nombreBebe: json['nombre_bebe'],
      cuidador: json['cuidador'],
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento']),
      createdAt: DateTime.parse(json['created_at']),
      palabras: json['palabras'] != null
          ? (json['palabras'] as List).map((palabra) => PalabraCDI1Valor.fromJson(jsonEncode(palabra))).toList()
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
