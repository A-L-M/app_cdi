import 'dart:convert';
import 'dart:developer';
import 'package:universal_html/html.dart';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

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

  Future<bool> borrarCDI2(int cdi2id) async {
    try {
      final res = await supabase.rpc('borrar_cdi2', params: {
        'id': cdi2id,
      });
      listadoCDI2.removeWhere((element) => element.cdi2Id == cdi2id);
      rows.removeWhere((element) => element.cells['cdi2_id']?.value == cdi2id);
      if (stateManager != null) stateManager!.notifyListeners();
      return res;
    } catch (e) {
      log('Error en borrarCDI2() - $e');
      return false;
    }
  }

  Future<bool> calificarP3L(int id, int? cal1, int? cal2, int? cal3) async {
    try {
      final index = listadoCDI2.indexWhere((element) => element.cdi2Id == id);

      listadoCDI2[index].parte2.ejemplo1Calificacion = cal1;
      listadoCDI2[index].parte2.ejemplo2Calificacion = cal2;
      listadoCDI2[index].parte2.ejemplo3Calificacion = cal3;

      await supabase.from('cdi2_parte2').update({
        'ejemplo1_calificacion': cal1,
        'ejemplo2_calificacion': cal2,
        'ejemplo3_calificacion': cal3,
      }).eq('cdi2_id', id);

      return true;
    } catch (e) {
      log('Error en calificarP3L() - $e');
      return false;
    }
  }

  Workbook crearArchivoExcel(
    List<SeccionPalabrasCDI2> seccionesPalabras, {
    bool multiple = false,
  }) {
    List<Map<String, String>> nombreSheets = [
      {'nombre': 'ONOMATOPEYAS', 'color': '#FF9900'},
      {'nombre': 'ANIMALES', 'color': '#CCCCCC'},
      {'nombre': 'VEHICULOS', 'color': '#FFFF99'},
      {'nombre': 'ALIMENTOS', 'color': '#99CCFF'},
      {'nombre': 'ROPA', 'color': '#FF99CC'},
      {'nombre': 'CUERPO', 'color': '#FFCC99'},
      {'nombre': 'JUGUETES', 'color': '#9966CC'},
      {'nombre': 'ART. HOGAR', 'color': '#33CCFF'},
      {'nombre': 'MUEBLES', 'color': '#CC0066'},
      {'nombre': 'EXTERIOR', 'color': '#009900'},
      {'nombre': 'LUGARES', 'color': '#669933'},
      {'nombre': 'PERSONAS', 'color': '#0033CC'},
      {'nombre': 'JUEGOS Y RUTINAS', 'color': '#CCFFCC'},
      {'nombre': 'ACCION', 'color': '#006666'},
      {'nombre': 'ESTADO', 'color': '#CCCC99'},
      {'nombre': 'TIEMPO', 'color': '#CC0000'},
      {'nombre': 'DESCRIPTIVAS', 'color': '#339966'},
      {'nombre': 'PRONOMBRES', 'color': '#33CCCC'},
      {'nombre': 'INTERROGATIVAS', 'color': '#FF6600'},
      {'nombre': 'ARTICULOS', 'color': '#660099'},
      {'nombre': 'CUANTIFICADORES', 'color': '#FFCC00'},
      {'nombre': 'LOCATIVOS', 'color': '#CCCCCC'},
      {'nombre': 'PREPOSICIONES', 'color': '#993366'},
      {'nombre': 'CONECTIVOS', 'color': '#CCCCCC'},
      {'nombre': 'RESULTADOS POR ID', 'color': '#FF0000'},
      if (multiple) {'nombre': 'RESULTADOS POR PALABRA', 'color': '#FF0000'},
      {'nombre': 'TOTALES', 'color': '#FF0000'},
    ];

    // Create a new Excel document.
    final Workbook workbook = Workbook(nombreSheets.length);

    for (var i = 0; i < nombreSheets.length; i++) {
      final currentSheet = workbook.worksheets[i];
      currentSheet.name = nombreSheets[i]['nombre'] ?? 'Sheet$i';
      currentSheet.tabColor = nombreSheets[i]['color'] ?? '#FF9900';
    }

    //Se agregan estilos de celda
    final CellStyle styleBold = CellStyle(workbook, 'StyleBold');
    styleBold.fontName = 'Arial';
    styleBold.fontSize = 12;
    styleBold.bold = true;
    styleBold.hAlign = HAlignType.center;
    styleBold.wrapText = true;

    final CellStyle styleSubrayada = CellStyle(workbook, 'StyleSubrayada');
    styleSubrayada.fontName = 'Arial';
    styleSubrayada.fontSize = 12;
    styleSubrayada.bold = true;
    styleSubrayada.underline = true;
    styleSubrayada.hAlign = HAlignType.center;
    styleSubrayada.wrapText = true;

    final CellStyle styleSombreada = CellStyle(workbook, 'StyleSombreada');
    styleSombreada.fontName = 'Arial';
    styleSombreada.fontSize = 12;
    styleSombreada.bold = true;
    styleSombreada.underline = true;
    styleSombreada.backColor = '#66CCCC';
    styleSombreada.hAlign = HAlignType.center;
    styleSombreada.wrapText = true;

    final CellStyle styleDatos = CellStyle(workbook, 'StyleDatos');
    styleDatos.fontName = 'Arial';
    styleDatos.fontSize = 12;
    styleDatos.hAlign = HAlignType.center;
    styleDatos.wrapText = true;

    workbook.styles.addStyle(styleBold);
    workbook.styles.addStyle(styleSubrayada);
    workbook.styles.addStyle(styleSombreada);
    workbook.styles.addStyle(styleDatos);

    //Agregar titulos de columnas
    for (var i = 0; i < seccionesPalabras.length; i++) {
      final palabras = seccionesPalabras[i].palabras;

      final idCell = workbook.worksheets[i].getRangeByIndex(1, 1);
      idCell.setValue('ID');
      idCell.cellStyle = workbook.styles.innerList
          .singleWhere((style) => style.name == 'StyleBold');

      for (var j = 0; j < palabras.length; j++) {
        //se busca la celda
        final cell = workbook.worksheets[i].getRangeByIndex(1, j + 2);
        cell.setValue(palabras[j].nombre);
        cell.autoFitColumns();
        cell.autoFitRows();
        if (palabras[j].sombreada) {
          cell.cellStyle = workbook.styles.innerList
              .singleWhere((style) => style.name == 'StyleSombreada');
        } else if (palabras[j].subrayada && !palabras[j].sombreada) {
          cell.cellStyle = workbook.styles.innerList
              .singleWhere((style) => style.name == 'StyleSubrayada');
        } else {
          cell.cellStyle = workbook.styles.innerList
              .singleWhere((style) => style.name == 'StyleBold');
        }
      }
    }

    return workbook;
  }

  void guardarArchivoExcel(Workbook excel) {
    final List<int> bytes = excel.saveSync();

    excel.dispose();

    //Download the output file in web.
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "resultados.xlsx")
      ..click();
  }

  void llenarArchivoExcel(
    Workbook excel,
    List<CDI2> listaCDI2,
    List<SeccionPalabrasCDI2> seccionesPalabras,
  ) {
    for (var i = 0; i < seccionesPalabras.length; i++) {
      final palabras = seccionesPalabras[i].palabras;
      List<int> row = [];

      for (var j = 0; j < listaCDI2.length; j++) {
        //Se le asignan valores a las palabras
        for (var palabra in listaCDI2[j].palabras) {
          seccionesPalabras[palabra.seccionFk - 1].setPalabra(
            palabra.palabraId,
            palabra.opcion,
          );
        }
        for (var palabra in palabras) {
          row.add(convertToInt(palabra.opcion));
        }
        excel.worksheets[i]
            .importList([listaCDI2[j].bebeId, ...row], j + 2, 1, false);
        row.clear();
      }

      final datosRange = excel.worksheets[i].getRangeByIndex(
        2,
        1,
        listaCDI2.length + 1,
        palabras.length + 2,
      );
      datosRange.cellStyle = excel.styles.innerList
          .singleWhere((style) => style.name == 'StyleDatos');
    }
  }

  Future<List<SeccionPalabrasCDI2>> getSeccionesPalabras() async {
    List<SeccionPalabrasCDI2> seccionesPalabras = [];
    try {
      //Se obtienen todas las palabras divididas por seccion
      final res = await supabase.from('secciones_palabras_cdi2').select();

      seccionesPalabras = (res as List<dynamic>)
          .map((palabra) => SeccionPalabrasCDI2.fromJson(jsonEncode(palabra)))
          .toList();

      return seccionesPalabras;
    } catch (e) {
      log('Error al generar archivo Excel - $e');
      return [];
    }
  }

  Future<bool> generarReporteExcel(List<CDI2> listaCDI2) async {
    List<SeccionPalabrasCDI2> seccionesPalabras = [];

    seccionesPalabras = await getSeccionesPalabras();

    final excel = crearArchivoExcel(seccionesPalabras);

    //TODO: ver como ir cambiando los valores (poner en la otra funcion)

    llenarArchivoExcel(excel, listaCDI2, seccionesPalabras);

    guardarArchivoExcel(excel);

    excel.dispose();

    return true;
  }

  @override
  void dispose() {
    busquedaController.dispose();
    super.dispose();
  }
}
