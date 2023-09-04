import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
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

  Future<void> initState(int cdi2Id, {bool clear = true}) async {
    this.cdi2Id = cdi2Id;
    if (clear) {
      seccionesPalabras = [];
      comprension = CDI2Comprension.fromMap({});
      parte2 = CDI2Parte2.fromMap({});
      ejemplo1Controller.clear();
      ejemplo2Controller.clear();
      ejemplo3Controller.clear();
    }
    await getSeccionesPalabras();
  }

  void initEditarCDI2(CDI2 cdi2) {
    //Se le asignan valores a las palabras
    for (var palabra in cdi2.palabras) {
      seccionesPalabras[palabra.seccionFk - 1].setPalabra(
        palabra.palabraId,
        palabra.opcion,
      );
    }
    comprension = cdi2.comprension;
    parte2 = cdi2.parte2;
    ejemplo1Controller.text = cdi2.parte2.ejemplo1 ?? '';
    ejemplo2Controller.text = cdi2.parte2.ejemplo2 ?? '';
    ejemplo3Controller.text = cdi2.parte2.ejemplo3 ?? '';
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
        'valor': convertToInt(opcion),
      });
    } catch (e) {
      log('Error en setOpcionPalabra() - $e');
    }
  }

  Future<void> setOpcionComprension(
    RespuestaComprension valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi2_comprension').update(
        {'pregunta${indexPregunta + 1}': convertToString(valor)},
      ).eq('cdi2_id', cdi2Id);
    } catch (e) {
      log('Error en setOpcionComprension() - $e');
    }
  }

  Future<void> setVerbo(String dbName, bool value) async {
    try {
      await supabase
          .from('cdi2_parte2')
          .update({dbName: value}).eq('cdi2_id', cdi2Id);
    } catch (e) {
      log('Error en setVerbo() - $e');
    }
  }

  Future<void> setCombinaPalabras(RespuestaComprension opcion) async {
    parte2.combinaPalabras = opcion;
    notifyListeners();
    try {
      await supabase.from('cdi2_parte2').update(
        {
          'combina_palabras': convertToString(opcion),
        },
      ).eq('cdi2_id', cdi2Id);
    } catch (e) {
      log('Error en setCombinaPalabras() - $e');
    }
  }

  Future<void> guardarFrasesIncisoB() async {
    try {
      await supabase.from('cdi2_parte2').update(
        {
          'ejemplo1': ejemplo1Controller.text,
          'ejemplo2': ejemplo2Controller.text,
          'ejemplo3': ejemplo3Controller.text,
        },
      ).eq('cdi2_id', cdi2Id);
    } catch (e) {
      log('Error en guardarFrasesIncisoB() - $e');
    }
  }

  Future<void> setComplejidad(String complejidad, int valor) async {
    try {
      await supabase.from('cdi2_parte2').update(
        {
          'complejidad$complejidad': valor,
        },
      ).eq('cdi2_id', cdi2Id);
    } catch (e) {
      log('Error en setComplejidad() - $e');
    }
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

  @override
  void dispose() {
    ejemplo1Controller.dispose();
    ejemplo2Controller.dispose();
    ejemplo3Controller.dispose();
    super.dispose();
  }
}
