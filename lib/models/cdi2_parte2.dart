import 'dart:convert';

import 'package:app_cdi/models/models.dart';

class CDI2Parte2 {
  CDI2Parte2({
    required this.cdi2Id,
    required this.acabo,
    required this.acabas,
    required this.acaba,
    required this.acabamos,
    required this.como,
    required this.comes,
    required this.come,
    required this.comemos,
    required this.subo,
    required this.subes,
    required this.sube,
    required this.subimos,
    required this.acabe,
    required this.acabo2,
    required this.comi,
    required this.comio,
    required this.subi,
    required this.subio,
    required this.acaba2,
    required this.acabate,
    required this.come2,
    required this.comete,
    required this.sube2,
    required this.subete,
    required this.combinaPalabras,
    required this.ejemplo1,
    required this.ejemplo1Calificacion,
    required this.ejemplo2,
    required this.ejemplo2Calificacion,
    required this.ejemplo3,
    required this.ejemplo3Calificacion,
    required this.complejidad1,
    required this.complejidad2,
    required this.complejidad3,
    required this.complejidad4,
    required this.complejidad5,
    required this.complejidad6,
    required this.complejidad7,
    required this.complejidad8,
    required this.complejidad9,
    required this.complejidad10,
    required this.complejidad11,
    required this.complejidad12,
    required this.complejidad13,
    required this.complejidad14,
    required this.complejidad15,
    required this.complejidad16,
    required this.complejidad17,
    required this.complejidad18,
    required this.complejidad19,
    required this.complejidad20,
    required this.complejidad21,
    required this.complejidad22,
    required this.complejidad23,
    required this.complejidad24,
    required this.complejidad25,
    required this.complejidad26,
    required this.complejidad27,
    required this.complejidad28,
    required this.complejidad29,
    required this.complejidad30,
    required this.complejidad31,
    required this.complejidad32,
    required this.complejidad33,
    required this.complejidad34,
    required this.complejidad35,
    required this.complejidad36,
    required this.complejidad37,
  });

  int? cdi2Id;
  bool acabo = false;
  bool acabas = false;
  bool acaba = false;
  bool acabamos = false;
  bool como = false;
  bool comes = false;
  bool come = false;
  bool comemos = false;
  bool subo = false;
  bool subes = false;
  bool sube = false;
  bool subimos = false;
  bool acabe = false;
  bool acabo2 = false;
  bool comi = false;
  bool comio = false;
  bool subi = false;
  bool subio = false;
  bool acaba2 = false;
  bool acabate = false;
  bool come2 = false;
  bool comete = false;
  bool sube2 = false;
  bool subete = false;
  RespuestaComprension? combinaPalabras;
  String? ejemplo1;
  int? ejemplo1Calificacion;
  int? ejemplo2Calificacion;
  int? ejemplo3Calificacion;
  String? ejemplo2;
  String? ejemplo3;
  int? complejidad1;
  int? complejidad2;
  int? complejidad3;
  int? complejidad4;
  int? complejidad5;
  int? complejidad6;
  int? complejidad7;
  int? complejidad8;
  int? complejidad9;
  int? complejidad10;
  int? complejidad11;
  int? complejidad12;
  int? complejidad13;
  int? complejidad14;
  int? complejidad15;
  int? complejidad16;
  int? complejidad17;
  int? complejidad18;
  int? complejidad19;
  int? complejidad20;
  int? complejidad21;
  int? complejidad22;
  int? complejidad23;
  int? complejidad24;
  int? complejidad25;
  int? complejidad26;
  int? complejidad27;
  int? complejidad28;
  int? complejidad29;
  int? complejidad30;
  int? complejidad31;
  int? complejidad32;
  int? complejidad33;
  int? complejidad34;
  int? complejidad35;
  int? complejidad36;
  int? complejidad37;

  factory CDI2Parte2.fromJson(String str) => CDI2Parte2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  double get promedioP3L {
    double numEjemplos = 0;
    double promedio = 0;

    if (ejemplo1 != null || ejemplo1 != '') {
      numEjemplos += 1;
    }

    if (ejemplo2 != null || ejemplo2 != '') {
      numEjemplos += 1;
    }

    if (ejemplo3 != null || ejemplo3 != '') {
      numEjemplos += 1;
    }

    if (numEjemplos != 0) {
      promedio = ((ejemplo1Calificacion?.toDouble() ?? 0.0) +
              (ejemplo2Calificacion?.toDouble() ?? 0.0) +
              (ejemplo3Calificacion?.toDouble() ?? 0.0)) /
          numEjemplos;
    }
    return promedio;
  }

  List<int?> get listaComplejidad {
    return [
      complejidad1,
      complejidad2,
      complejidad3,
      complejidad4,
      complejidad5,
      complejidad6,
      complejidad7,
      complejidad8,
      complejidad9,
      complejidad10,
      complejidad11,
      complejidad12,
      complejidad13,
      complejidad14,
      complejidad15,
      complejidad16,
      complejidad17,
      complejidad18,
      complejidad19,
      complejidad20,
      complejidad21,
      complejidad22,
      complejidad23,
      complejidad24,
      complejidad25,
      complejidad26,
      complejidad27,
      complejidad28,
      complejidad29,
      complejidad30,
      complejidad31,
      complejidad32,
      complejidad33,
      complejidad34,
      complejidad35,
      complejidad36,
      complejidad37,
    ];
  }

  int calcularP3L() {
    if (combinaPalabras == RespuestaComprension.muchasVeces || combinaPalabras == RespuestaComprension.deVezEnCuando) {
      return promedioP3L.round();
    } else {
      return 0;
    }
  }

  factory CDI2Parte2.fromMap(Map<String, dynamic> json) {
    return CDI2Parte2(
      cdi2Id: json['cdi2_id'],
      acabo: json['acabo'] ?? false,
      acabas: json['acabas'] ?? false,
      acaba: json['acaba'] ?? false,
      acabamos: json['acabamos'] ?? false,
      como: json['como'] ?? false,
      comes: json['comes'] ?? false,
      come: json['come'] ?? false,
      comemos: json['comemos'] ?? false,
      subo: json['subo'] ?? false,
      subes: json['subes'] ?? false,
      sube: json['sube'] ?? false,
      subimos: json['subimos'] ?? false,
      acabe: json['acabe'] ?? false,
      acabo2: json['acabo2'] ?? false,
      comi: json['comi'] ?? false,
      comio: json['comio'] ?? false,
      subi: json['subi'] ?? false,
      subio: json['subio'] ?? false,
      acaba2: json['acaba2'] ?? false,
      acabate: json['acabate'] ?? false,
      come2: json['come2'] ?? false,
      comete: json['comete'] ?? false,
      sube2: json['sube2'] ?? false,
      subete: json['subete'] ?? false,
      combinaPalabras: convertToEnum(json['combina_palabras']),
      ejemplo1: json['ejemplo1'],
      ejemplo1Calificacion: json['ejemplo1_calificacion'],
      ejemplo2: json['ejemplo2'],
      ejemplo2Calificacion: json['ejemplo2_calificacion'],
      ejemplo3: json['ejemplo3'],
      ejemplo3Calificacion: json['ejemplo3_calificacion'],
      complejidad1: json['complejidad1'],
      complejidad2: json['complejidad2'],
      complejidad3: json['complejidad3'],
      complejidad4: json['complejidad4'],
      complejidad5: json['complejidad5'],
      complejidad6: json['complejidad6'],
      complejidad7: json['complejidad7'],
      complejidad8: json['complejidad8'],
      complejidad9: json['complejidad9'],
      complejidad10: json['complejidad10'],
      complejidad11: json['complejidad11'],
      complejidad12: json['complejidad12'],
      complejidad13: json['complejidad13'],
      complejidad14: json['complejidad14'],
      complejidad15: json['complejidad15'],
      complejidad16: json['complejidad16'],
      complejidad17: json['complejidad17'],
      complejidad18: json['complejidad18'],
      complejidad19: json['complejidad19'],
      complejidad20: json['complejidad20'],
      complejidad21: json['complejidad21'],
      complejidad22: json['complejidad22'],
      complejidad23: json['complejidad23'],
      complejidad24: json['complejidad24'],
      complejidad25: json['complejidad25'],
      complejidad26: json['complejidad26'],
      complejidad27: json['complejidad27'],
      complejidad28: json['complejidad28'],
      complejidad29: json['complejidad29'],
      complejidad30: json['complejidad30'],
      complejidad31: json['complejidad31'],
      complejidad32: json['complejidad32'],
      complejidad33: json['complejidad33'],
      complejidad34: json['complejidad34'],
      complejidad35: json['complejidad35'],
      complejidad36: json['complejidad36'],
      complejidad37: json['complejidad37'],
    );
  }

  Map<String, dynamic> toMap() => {
        "cdi2_id": cdi2Id,
        'acabo': acabo,
        'acabas': acabas,
        'acaba': acaba,
        'acabamos': acabamos,
        'como': como,
        'comes': comes,
        'come': come,
        'comemos': comemos,
        'subo': subo,
        'subes': subes,
        'sube': sube,
        'subimos': subimos,
        'acabe': acabe,
        'acabo2': acabo2,
        'comi': comi,
        'comio': comio,
        'subi': subi,
        'subio': subio,
        'acaba2': acaba2,
        'acabate': acabate,
        'come2': come2,
        'comete': comete,
        'sube2': sube2,
        'subete': subete,
        'combina_palabras': convertToString(combinaPalabras),
        'ejemplo1': ejemplo1,
        'ejemplo2': ejemplo2,
        'ejemplo3': ejemplo3,
        'complejidad1': complejidad1,
        'complejidad2': complejidad2,
        'complejidad3': complejidad3,
        'complejidad4': complejidad4,
        'complejidad5': complejidad5,
        'complejidad6': complejidad6,
        'complejidad7': complejidad7,
        'complejidad8': complejidad8,
        'complejidad9': complejidad9,
        'complejidad10': complejidad10,
        'complejidad11': complejidad11,
        'complejidad12': complejidad12,
        'complejidad13': complejidad13,
        'complejidad14': complejidad14,
        'complejidad15': complejidad15,
        'complejidad16': complejidad16,
        'complejidad17': complejidad17,
        'complejidad18': complejidad18,
        'complejidad19': complejidad19,
        'complejidad20': complejidad20,
        'complejidad21': complejidad21,
        'complejidad22': complejidad22,
        'complejidad23': complejidad23,
        'complejidad24': complejidad24,
        'complejidad25': complejidad25,
        'complejidad26': complejidad26,
        'complejidad27': complejidad27,
        'complejidad28': complejidad28,
        'complejidad29': complejidad29,
        'complejidad30': complejidad30,
        'complejidad31': complejidad31,
        'complejidad32': complejidad32,
        'complejidad33': complejidad33,
        'complejidad34': complejidad34,
        'complejidad35': complejidad35,
        'complejidad36': complejidad36,
        'complejidad37': complejidad37,
      };
}
