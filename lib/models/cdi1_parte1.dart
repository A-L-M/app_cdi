import 'dart:convert';

import 'package:app_cdi/models/enums.dart';

class CDI1Parte1 {
  CDI1Parte1({
    required this.cdi1Id,
    required this.listaComprension,
    required this.listaFrases,
    required this.listaHablar,
  });

  int? cdi1Id;
  List<bool?> listaComprension = [];
  List<bool> listaFrases = [];
  List<RespuestaComprension> listaHablar = [];

  factory CDI1Parte1.fromJson(String str) =>
      CDI1Parte1.fromMap(json.decode(str));

  factory CDI1Parte1.fromMap(Map<String, dynamic> json) {
    final List<bool?> comprensionTemp = [];
    comprensionTemp.add(json['comprension1']);
    comprensionTemp.add(json['comprension2']);
    comprensionTemp.add(json['comprension3']);

    final List<bool> listaFrasesTemp = [];
    for (var i = 1; i <= 28; i++) {
      listaFrasesTemp.add(json['primera_frase$i'] ?? false);
    }

    final List<RespuestaComprension> listaHablarTemp = [];
    listaHablarTemp.add(convertToEnum(json['hablar1']));
    listaHablarTemp.add(convertToEnum(json['hablar2']));

    return CDI1Parte1(
      cdi1Id: json['cdi1_id'],
      listaComprension: comprensionTemp,
      listaFrases: listaFrasesTemp,
      listaHablar: listaHablarTemp,
    );
  }
}
