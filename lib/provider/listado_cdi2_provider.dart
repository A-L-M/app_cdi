import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

class ListadoCDI2Provider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<CDI2> listadoCDI2 = [];

  CDI2? cdi2Editado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "cdi2_id";

  Future<void> updateState() async {
    await getListadoCDI2();
  }

  Future<void> getListadoCDI2() async {
    try {
      final query = supabase.from('cdi2_completo').select();

      final res = await query
          .like('nombre_bebe', '%${busquedaController.text}%')
          .order(orden, ascending: false);

      if (res == null) {
        log('Error en getListadoCDI2()');
        return;
      }

      listadoCDI2 = (res as List<dynamic>)
          .map((usuario) => CDI2.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (CDI2 cdi2 in listadoCDI2) {
        rows.add(
          PlutoRow(
            cells: {
              'cdi2_id': PlutoCell(value: cdi2.cdi2Id),
              'bebe_id': PlutoCell(value: cdi2.bebeId),
              'nombre_bebe': PlutoCell(value: cdi2.nombreBebe),
              'created_at':
                  PlutoCell(value: cdi2.createdAt.parseToString('yyyy-MM-dd')),
              'acciones': PlutoCell(value: cdi2.cdi2Id.toString()),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getListadoCDI2() - $e');
    }

    notifyListeners();
  }

  Future<bool> generarReporteExcel(CDI2 cdi2) async {
    List<SeccionPalabrasCDI2> seccionesPalabras = [];
    try {
      //Se obtienen todas las palabras divididas por seccion
      final res = await supabase.from('secciones_palabras_cdi2').select();

      seccionesPalabras = (res as List<dynamic>)
          .map((palabra) => SeccionPalabrasCDI2.fromJson(jsonEncode(palabra)))
          .toList();

      //Se le asignan valores a las palabras
      for (var palabra in cdi2.palabras) {
        seccionesPalabras[palabra.seccionFk - 1].setPalabra(
          palabra.palabraId,
          palabra.opcion,
        );
      }
    } catch (e) {
      log('Error al generar archivo Excel');
      return false;
    }
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
      'EXTERIOR',
      'LUGARES',
      'PERSONAS',
      'JUEGOS Y RUTINAS',
      'ACCION',
      'ESTADO',
      'TIEMPO',
      'DESCRIPTIVAS',
      'PRONOMBRES',
      'INTERROGATIVAS',
      'ARTICULOS',
      'CUANTIFICADORES',
      'LOCATIVOS',
      'PREPOSICIONES',
      'CONECTIVOS',
    ];

    for (var nombre in nombreSheets) {
      excel.copy(excel.getDefaultSheet() ?? 'Sheet1', nombre);
    }

    List<Sheet?> sheets = [];

    excel.delete(excel.getDefaultSheet() ?? 'Sheet1');

    for (var nombre in nombreSheets) {
      sheets.add(excel.sheets[nombre]);
    }

    for (var i = 0; i < seccionesPalabras.length; i++) {
      List<String> nombresSeccion =
          seccionesPalabras[i].palabras.map((e) => e.nombre).toList();
      List<dynamic> row = [];

      for (var palabra in seccionesPalabras[i].palabras) {
        row.add(PalabraCDI2.convertToInt(palabra.opcion));
      }

      sheets[i]!.appendRow(['ID', ...nombresSeccion]);
      sheets[i]!.appendRow([cdi2.bebeId, ...row]);
    }

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "resultados.xlsx");
    if (fileBytes == null) return false;

    return true;
  }

  @override
  void dispose() {
    busquedaController.dispose();
    super.dispose();
  }
}
