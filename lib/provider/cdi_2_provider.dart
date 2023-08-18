import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/models/seccion_palabras_cdi2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class CDI2Provider extends ChangeNotifier {
  int? cdi2Id;

  List<SeccionPalabrasCDI2> seccionesPalabras = [];
  CDI2Comprension comprension = CDI2Comprension.fromMap({});
  CDI2Parte2 parte2 = CDI2Parte2.fromMap({});

  TextEditingController ejemplo1Controller = TextEditingController();
  TextEditingController ejemplo2Controller = TextEditingController();
  TextEditingController ejemplo3Controller = TextEditingController();

  CDI2Provider() {
    ejemplo1Controller.text = parte2.ejemplo1 ?? '';
    ejemplo2Controller.text = parte2.ejemplo2 ?? '';
    ejemplo3Controller.text = parte2.ejemplo3 ?? '';
  }

  Future<void> initState(int cdi2Id) async {
    this.cdi2Id = cdi2Id;
    await getSeccionesPalabras();
  }

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

  void setOpcionPalabra(Opcion opcion, PalabraCDI2 palabra) async {
    palabra.opcion = opcion;
    notifyListeners();
    try {
      await supabase.rpc('upsert_palabra_cdi2', params: {
        'cdi2_id': cdi2Id,
        'palabra_id': palabra.palabraId,
        'valor': PalabraCDI2.convertToInt(opcion),
      });
    } catch (e) {
      log('Error en setOpcionPalabra() - $e');
    }
  }

  void setCombinaPalabras(RespuestaComprension opcion) {
    parte2.combinaPalabras = opcion;
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

  @override
  void dispose() {
    ejemplo1Controller.dispose();
    ejemplo2Controller.dispose();
    ejemplo3Controller.dispose();
    super.dispose();
  }
}
