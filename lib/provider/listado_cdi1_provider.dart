import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

class ListadoCDI1Provider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<CDI1> listadoCDI1 = [];

  CDI2? cdi1Editado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "cdi1_id";

  Future<void> updateState() async {
    await getListadoCDI1();
  }

  Future<void> getListadoCDI1() async {
    try {
      final query = supabase.from('cdi1_completo').select();

      final res = await query
          .like('nombre_bebe', '%${busquedaController.text}%')
          .order(orden, ascending: false);

      if (res == null) {
        log('Error en getListadoCDI1()');
        return;
      }

      listadoCDI1 = (res as List<dynamic>)
          .map((usuario) => CDI1.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (CDI1 cdi1 in listadoCDI1) {
        rows.add(
          PlutoRow(
            cells: {
              'cdi1_id': PlutoCell(value: cdi1.cdi1Id),
              'bebe_id': PlutoCell(value: cdi1.bebeId),
              'nombre_bebe': PlutoCell(value: cdi1.nombreBebe),
              'created_at':
                  PlutoCell(value: cdi1.createdAt.parseToString('yyyy-MM-dd')),
              'acciones': PlutoCell(value: cdi1.cdi1Id.toString()),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getListadoCDI1() - $e');
    }

    notifyListeners();
  }

  Future<bool> borrarCDI1(int cdi1id) async {
    try {
      final res = await supabase.rpc('borrar_cdi1', params: {
        'id': cdi1id,
      });
      listadoCDI1.removeWhere((element) => element.cdi1Id == cdi1id);
      rows.removeWhere((element) => element.cells['cdi1_id']?.value == cdi1id);
      if (stateManager != null) stateManager!.notifyListeners();
      return res;
    } catch (e) {
      log('Error en borrarCDI2() - $e');
      return false;
    }
  }

  Future<bool> generarReporteExcel(CDI1 cdi1) async {
    List<SeccionPalabrasCDI2> seccionesPalabras = [];
    try {
      //Se obtienen todas las palabras divididas por seccion
      final res = await supabase.from('secciones_palabras_cdi1').select();

      seccionesPalabras = (res as List<dynamic>)
          .map((palabra) => SeccionPalabrasCDI2.fromJson(jsonEncode(palabra)))
          .toList();

      //Se le asignan valores a las palabras
      for (var palabra in cdi1.palabras) {
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
        row.add(convertToInt(palabra.opcion));
      }

      sheets[i]!.appendRow(['ID', ...nombresSeccion]);
      //Agregar edad
      sheets[i]!.appendRow([cdi1.bebeId, ...row]);
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
