import 'dart:convert';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/tablas.dart';
import 'package:app_cdi/models/models.dart';

class CDI2 {
  CDI2({
    required this.cdi2Id,
    required this.bebeId,
    required this.nombreBebe,
    required this.cuidador,
    required this.fechaNacimiento,
    required this.createdAt,
    required this.palabras,
    required this.comprension,
    required this.parte2,
  });

  int cdi2Id;
  int bebeId;
  String nombreBebe;
  String cuidador;
  DateTime fechaNacimiento;
  DateTime createdAt;
  List<PalabraCDI2Valor> palabras;
  CDI2Comprension comprension;
  CDI2Parte2 parte2;

  int get edad {
    final yearsDifference = createdAt.year - fechaNacimiento.year;
    int months = (yearsDifference * 12) - fechaNacimiento.month + createdAt.month;
    if (createdAt.day < fechaNacimiento.day) months -= 1;
    return months;
  }

  String get edadConDias {
    final yearsDifference = createdAt.year - fechaNacimiento.year;
    int months = (yearsDifference * 12) - fechaNacimiento.month + createdAt.month;
    if (createdAt.day < fechaNacimiento.day) months -= 1;
    int dias = 0;
    if (createdAt.day >= fechaNacimiento.day) {
      dias = createdAt.day - fechaNacimiento.day;
    } else {
      dias = 30 - (fechaNacimiento.day - createdAt.day);
    }
    return '${months.toString()} meses ${dias.toString()} días';
  }

  ({int meses, int dias}) get edadConDiasRecord {
    final yearsDifference = createdAt.year - fechaNacimiento.year;
    int months = (yearsDifference * 12) - fechaNacimiento.month + createdAt.month;
    if (createdAt.day < fechaNacimiento.day) months -= 1;
    int dias = 0;
    if (createdAt.day >= fechaNacimiento.day) {
      dias = createdAt.day - fechaNacimiento.day;
    } else {
      dias = 30 - (fechaNacimiento.day - createdAt.day);
    }
    return (meses: months, dias: dias);
  }

  ({int natural, int percentil}) calcularProduccion() {
    int puntajeNatural = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprendeYDice) puntajeNatural += 1;
    }
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.produccionPalabrasCDI2, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularP3L() {
    int puntajeNatural = parte2.calcularP3L();
    if (puntajeNatural == 0) {
      //Se revisa si se dijo palabras
      if (palabras.any((palabra) => palabra.opcion == Opcion.comprendeYDice)) {
        puntajeNatural = 1;
      }
    }
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.p3lPalabrasCDI2, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  ({int natural, int percentil}) calcularComplejidad() {
    int puntajeNatural = 0;
    for (var valor in parte2.listaComplejidad) {
      if (valor == 1) puntajeNatural += 1;
    }
    int puntajePercentil =
        Tablas.calcularPercentil(tabla: Tablas.complejidadFrasesCDI2, edad: edad, numPalabras: puntajeNatural);
    return (natural: puntajeNatural, percentil: puntajePercentil);
  }

  factory CDI2.fromJson(String str) => CDI2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDI2.fromMap(Map<String, dynamic> json) {
    return CDI2(
      cdi2Id: json['cdi2_id'],
      bebeId: json['bebe_id'],
      nombreBebe: json['nombre_bebe'],
      cuidador: json['cuidador'],
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
