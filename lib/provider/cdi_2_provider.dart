import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/models/seccion_palabras_cdi2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class CDI2Provider extends ChangeNotifier {
  List<SeccionPalabrasCDI2> seccionesPalabras = [];
  CDI2Comprension comprension = CDI2Comprension.fromMap({});

  Future<void> getSeccionesPalabras() async {
    if (seccionesPalabras.isNotEmpty) return;

    try {
      final res = await supabase.from('secciones_palabras_cdi2').select();

      seccionesPalabras = (res as List<dynamic>)
          .map((palabra) => SeccionPalabrasCDI2.fromJson(jsonEncode(palabra)))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error en getPalabrasSeccion - $e');
    }
  }

  void setOpcionPalabra(Opcion opcion, PalabraCDI2 palabra) {
    palabra.opcion = opcion;
    notifyListeners();
  }

  int getTotalC(List<PalabraCDI2> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.subrayada && palabra.opcion == Opcion.comprende) total += 1;
    }
    return total;
  }

  int getTotalCD(List<PalabraCDI2> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.subrayada && palabra.opcion == Opcion.comprendeYDice) {
        total += 1;
      }
    }
    return total;
  }

  int getTotalD(List<PalabraCDI2> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprendeYDice) {
        total += 1;
      }
    }
    return total;
  }

  Future<bool> generarReporteExcel(String bebeId) async {
    //Crear excel
    Excel excel = Excel.createExcel();

    List<String> nombreSheets = [
      'ONOMATOPEYAS',
      'ANIMALES',
      'VEHICULOS',
      'ALIMENTOS',
      'ROPA',
      'CUERPO',
      'JUGUETES',
      'ART. HOGAR',
      'MUEBLES',
      'HOGAR',
    ];

    for (var nombre in nombreSheets) {
      excel.copy(excel.getDefaultSheet() ?? 'Sheet1', nombre);
    }

    List<Sheet?> sheets = [];

    excel.delete(excel.getDefaultSheet() ?? 'Sheet1');

    for (var nombre in nombreSheets) {
      sheets.add(excel.sheets[nombre]);
    }

    //1
    List<String> nombresSeccion1 =
        seccionesPalabras[0].palabras.map((e) => e.nombre).toList();

    List<dynamic> row = [];

    for (var palabra in seccionesPalabras[0].palabras) {
      int coding = 0;
      if (palabra.opcion == Opcion.comprende) {
        coding = 1;
      } else if (palabra.opcion == Opcion.comprendeYDice) {
        coding = 2;
      }
      row.add(coding);
    }

    sheets[0]!.appendRow(['ID', ...nombresSeccion1]);
    sheets[0]!.appendRow([bebeId, ...row]);

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "resultados.xlsx");
    if (fileBytes == null) return false;

    return true;
  }
}
