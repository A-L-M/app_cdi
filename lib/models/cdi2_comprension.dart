import 'dart:convert';

import 'package:app_cdi/models/enums.dart';

class CDI2Comprension {
  CDI2Comprension({
    required this.cdi2Id,
    required this.preguntas,
  });

  int? cdi2Id;
  List<RespuestaComprension> preguntas = [];

  factory CDI2Comprension.fromJson(String str) => CDI2Comprension.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CDI2Comprension.fromMap(Map<String, dynamic> json) {
    final List<RespuestaComprension> preguntasTemp = [];
    preguntasTemp.add(convertToEnum(json["pregunta1"]));
    preguntasTemp.add(convertToEnum(json["pregunta2"]));
    preguntasTemp.add(convertToEnum(json["pregunta3"]));
    preguntasTemp.add(convertToEnum(json["pregunta4"]));
    preguntasTemp.add(convertToEnum(json["pregunta5"]));
    return CDI2Comprension(
      cdi2Id: json['cdi2_id'],
      preguntas: preguntasTemp,
    );
  }

  Map<String, dynamic> toMap() => {
        "cdi2_id": cdi2Id,
        "pregunta1": convertToString(preguntas[0]),
        "pregunta2": convertToString(preguntas[1]),
        "pregunta3": convertToString(preguntas[2]),
        "pregunta4": convertToString(preguntas[3]),
        "pregunta5": convertToString(preguntas[4]),
      };
}
