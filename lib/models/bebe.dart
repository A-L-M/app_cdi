import 'dart:convert';

import 'package:app_cdi/helpers/datetime_extension.dart';

enum Sexo { hombre, mujer }

class Bebe {
  Bebe({
    required this.bebeId,
    required this.nombreCuidador,
    required this.nombre,
    required this.apellidoPaterno,
    this.apellidoMaterno,
    required this.sexo,
    required this.fechaNacimiento,
  });

  int bebeId;
  String nombreCuidador;
  String nombre;
  String apellidoPaterno;
  String? apellidoMaterno;
  Sexo sexo;
  DateTime fechaNacimiento;

  factory Bebe.fromJson(String str) => Bebe.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bebe.fromMap(Map<String, dynamic> json) {
    return Bebe(
      bebeId: json['bebe_id'],
      nombreCuidador: json['cuidador'],
      nombre: json['nombre'],
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      sexo: convertToEnum(json['sexo']),
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento']),
    );
  }

  Map<String, dynamic> toMap() => {
        'bebe_id': bebeId,
        'cuidador': nombreCuidador,
        'nombre': nombre,
        'apellido_paterno': apellidoPaterno,
        'apellido_materno': apellidoMaterno,
        'sexo': convertToString(sexo),
        'fecha_nacimiento': fechaNacimiento.parseToString('yyyy-MM-dd'),
      };

  static String convertToString(Sexo? value) {
    switch (value) {
      case Sexo.hombre:
        return 'H';
      case Sexo.mujer:
        return 'M';
      default:
        return 'M';
    }
  }

  static Sexo convertToEnum(String? value) {
    switch (value) {
      case 'H':
        return Sexo.hombre;
      case 'M':
        return Sexo.mujer;
      default:
        return Sexo.mujer;
    }
  }
}
