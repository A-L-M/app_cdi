import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:flutter/material.dart';

class CDI1Provider extends ChangeNotifier {
  int? cdi1Id;

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

      seccionesPalabras =
          (res as List<dynamic>).map((palabra) => SeccionPalabrasCDI1.fromJson(jsonEncode(palabra))).toList();

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
      parte1.listaComprension[indexPregunta] = valor;
    } catch (e) {
      log('Error en setOpcionComprension() - $e');
    }
  }

  Future<void> setFraseIncisoB(
    int index,
    bool valor,
  ) async {
    try {
      await supabase.from('cdi1_parte1').update(
        {'primera_frase${index + 1}': valor},
      ).eq('cdi1_id', cdi1Id);
      parte1.listaFrases[index] = valor;
    } catch (e) {
      log('Error en setOpcionComprension() - $e');
    }
  }

  Future<void> setManeraHablarIncisoC(
    RespuestaComprension valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte1').update(
        {'hablar${indexPregunta + 1}': convertToString(valor)},
      ).eq('cdi1_id', cdi1Id);
    } catch (e) {
      log('Error en setOpcionComprension() - $e');
    }
  }

  //PARTE 2
  Future<void> setGestosIncisoA(
    RespuestaComprension valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte2').update(
        {'gesto${indexPregunta + 1}': convertToString(valor)},
      ).eq('cdi1_id', cdi1Id);
      parte2.listaGestos[indexPregunta] = valor;
    } catch (e) {
      log('Error en setGestosIncisoA() - $e');
    }
  }

  Future<void> setRutinasIncisoB(
    bool valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte2').update(
        {'rutinas${indexPregunta + 1}': valor},
      ).eq('cdi1_id', cdi1Id);
      parte2.listaRutinas[indexPregunta] = valor;
    } catch (e) {
      log('Error en setRutinasIncisoB() - $e');
    }
  }

  Future<void> setAccionesIncisoC(
    bool valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte2').update(
        {'acciones${indexPregunta + 1}': valor},
      ).eq('cdi1_id', cdi1Id);
      parte2.listaAcciones[indexPregunta] = valor;
    } catch (e) {
      log('Error en setAccionesIncisoC() - $e');
    }
  }

  Future<void> setJuegosIncisoD(
    bool valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte2').update(
        {'juegos${indexPregunta + 1}': valor},
      ).eq('cdi1_id', cdi1Id);
      parte2.listaJuegos[indexPregunta] = valor;
    } catch (e) {
      log('Error en setJuegosIncisoD() - $e');
    }
  }

  Future<void> setImitacionesIncisoE(
    bool valor,
    int indexPregunta,
  ) async {
    try {
      await supabase.from('cdi1_parte2').update(
        {'imitacion${indexPregunta + 1}': valor},
      ).eq('cdi1_id', cdi1Id);
      parte2.listaImitaciones[indexPregunta] = valor;
    } catch (e) {
      log('Error en setImitacionesIncisoE() - $e');
    }
  }
}
