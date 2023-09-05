import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/models/seccion_palabras_cdi1.dart';
import 'package:flutter/material.dart';

class CDI1Provider extends ChangeNotifier {
  //TODO: cambiar (debug)
  int? cdi1Id = 1;

  List<SeccionPalabrasCDI1> seccionesPalabras = [];
  CDI1Parte1 parte1 = CDI1Parte1.fromMap({});
  CDI1Parte2 parte2 = CDI1Parte2.fromMap({});

  Future<void> initState(int cdi1Id, {bool clear = true}) async {
    this.cdi1Id = cdi1Id;
    if (clear) {
      seccionesPalabras = [];
      parte1 = CDI1Parte1.fromMap({});
      parte2 = CDI1Parte2.fromMap({});
    }
    await getSeccionesPalabras();
  }

  void initEditarCDI1(CDI1 cdi1) {
    //Se le asignan valores a las palabras
    for (var palabra in cdi1.palabras) {
      seccionesPalabras[palabra.seccionFk - 1].setPalabra(
        palabra.palabraId,
        palabra.opcion,
      );
    }
    parte1 = cdi1.parte1;
    parte2 = cdi1.parte2;
  }

  Future<void> getSeccionesPalabras() async {
    if (seccionesPalabras.isNotEmpty) return;

    try {
      final res = await supabase.from('secciones_palabras_cdi1').select();

      seccionesPalabras = (res as List<dynamic>)
          .map((palabra) => SeccionPalabrasCDI1.fromJson(jsonEncode(palabra)))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error en getSeccionesPalabras() - $e');
    }
  }

  void setOpcionPalabra(Opcion opcion, PalabraCDI1 palabra) async {
    palabra.opcion = opcion;
    notifyListeners();
    try {
      await supabase.rpc('upsert_palabra_cdi1', params: {
        'cdi1_id': cdi1Id,
        'palabra_id': palabra.palabraId,
        'valor': convertToInt(opcion),
      });
    } catch (e) {
      log('Error en setOpcionPalabra() - $e');
    }
  }

  Future<void> setComprensionIncisoA(
    bool valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte1').update(
        {'comprension${indexPregunta + 1}': valor},
      ).eq('cdi1_id', cdi1Id);
    } catch (e) {
      log('Error en setOpcionComprension() - $e');
    }
  }
}
