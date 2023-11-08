import 'dart:convert';
import 'dart:developer';
import 'package:universal_html/html.dart';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/helpers/functions/remove_diacritics.dart';

class ListadoCDI2Provider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<CDI2> listadoCDI2 = [];
  List<CDI2> listadoCDI2Filtrado = [];

  CDI2? cdi2Editado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "cdi2_id";

  Future<void> updateState() async {
    await getListadoCDI2();
  }

  Future<void> getListadoCDI2() async {
    try {
      final res = await supabase.from('cdi2_completo').select().order(orden, ascending: false);

      if (res == null) {
        log('Error en getListadoCDI2()');
        return;
      }

      listadoCDI2 = (res as List<dynamic>).map((usuario) => CDI2.fromMap(usuario)).toList();
      listadoCDI2Filtrado = [...listadoCDI2];

      llenarPlutoGrid(listadoCDI2);
    } catch (e) {
      log('Error en getListadoCDI2() - $e');
    }
  }

  void llenarPlutoGrid(List<CDI2> listadoCDI2) {
    rows.clear();
    listadoCDI2Filtrado = [...listadoCDI2];
    for (CDI2 cdi2 in listadoCDI2) {
      rows.add(
        PlutoRow(
          cells: {
            'cdi2_id': PlutoCell(value: cdi2.cdi2Id),
            'bebe_id': PlutoCell(value: cdi2.bebeId),
            'nombre_bebe': PlutoCell(value: cdi2.nombreBebe),
            'edad': PlutoCell(value: cdi2.edadConDias),
            'created_at': PlutoCell(value: cdi2.createdAt.parseToString('yyyy-MM-dd')),
            'acciones': PlutoCell(value: cdi2.cdi2Id.toString()),
          },
        ),
      );
    }
    if (stateManager != null) stateManager!.notifyListeners();
    notifyListeners();
  }

  void filtrarCDI2() {
    //Revisar que exista busqueda
    if (busquedaController.text.isEmpty) {
      listadoCDI2Filtrado = [...listadoCDI2];
      llenarPlutoGrid(listadoCDI2Filtrado);
      return;
    }

    //Revisar que se este buscando un id
    final int? id = int.tryParse(busquedaController.text);
    if (id != null) {
      listadoCDI2Filtrado =
          listadoCDI2.where((registro) => registro.bebeId.toString().contains(id.toString())).toList();
      llenarPlutoGrid(listadoCDI2Filtrado);
      return;
    }

    //Revisar que se este buscando un nombre
    final String busqueda = removeDiacritics(busquedaController.text).toLowerCase();
    listadoCDI2Filtrado = listadoCDI2.where((registro) {
      final String nombreBebe = removeDiacritics(registro.nombreBebe).toLowerCase();
      if (nombreBebe.contains(busqueda)) return true;
      return false;
    }).toList();

    llenarPlutoGrid(listadoCDI2Filtrado);
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
      {'nombre': 'DESCRIPTIVAS', 'color': '#339966'},
      {'nombre': 'TIEMPO', 'color': '#CC0000'},
      {'nombre': 'PRONOMBRES', 'color': '#33CCCC'},
      {'nombre': 'INTERROGATIVAS', 'color': '#FF6600'},
      {'nombre': 'ARTICULOS', 'color': '#660099'},
      {'nombre': 'CUANTIFICADORES', 'color': '#FFCC00'},
      {'nombre': 'LOCATIVOS', 'color': '#CCCCCC'},
      {'nombre': 'CONECTIVOS', 'color': '#CCCCCC'},
      {'nombre': 'RESULTADOS POR ID', 'color': '#FF0000'},
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
      idCell.cellStyle = styleBold;

      final edadMesesCell = workbook.worksheets[i].getRangeByIndex(1, 2);
      edadMesesCell.setValue('Edad (Meses)');
      edadMesesCell.cellStyle = styleBold;
      edadMesesCell.columnWidth = 14;

      final edadDiasCell = workbook.worksheets[i].getRangeByIndex(1, 3);
      edadDiasCell.setValue('Edad (Días)');
      edadDiasCell.cellStyle = styleBold;
      edadDiasCell.columnWidth = 12;

      for (var j = 0; j < palabras.length; j++) {
        //se busca la celda
        final cell = workbook.worksheets[i].getRangeByIndex(1, j + 4);
        cell.setValue(palabras[j].nombre);
        cell.autoFitColumns();
        cell.autoFitRows();
        if (palabras[j].sombreada) {
          cell.cellStyle = styleSombreada;
        } else if (palabras[j].subrayada && !palabras[j].sombreada) {
          cell.cellStyle = styleSubrayada;
        } else {
          cell.cellStyle = styleBold;
        }
      }
    }

    initColumnasResultadosPorId(workbook, nombreSheets);
    initTotales(workbook);
    return workbook;
  }

  void initColumnasResultadosPorId(
    Workbook excel,
    List<Map<String, String>> nombreSheets,
  ) {
    final sheet = excel.worksheets['RESULTADOS POR ID'];
    final copy = [
      {'nombre': '   ID   ', 'color': '#FFFFFF'},
      {'nombre': 'Edad (Meses)', 'color': '#FFFFFF'},
      {'nombre': 'Edad (Días)', 'color': '#FFFFFF'},
      ...nombreSheets,
      {'nombre': 'TOTAL X NIÑO', 'color': '#CCCCCC'},
      {'nombre': 'TOTAL C+C/D', 'color': '#FFFFFF'},
      {'nombre': 'TOTAL X NIÑO ICPLIM', 'color': '#CCCCCC'},
      {'nombre': 'TOTAL C+C/D ICPLIM', 'color': '#FFFFFF'},
    ];
    copy.removeWhere((element) => element['nombre'] == 'RESULTADOS POR ID');
    copy.removeWhere((element) => element['nombre'] == 'RESULTADOS POR PALABRA');
    copy.removeWhere((element) => element['nombre'] == 'TOTALES');

    for (var i = 0; i < copy.length; i++) {
      Range cell;
      if (i == 0 || i == 1 || i == 2) {
        cell = sheet.getRangeByIndex(1, i + 1);
      } else {
        cell = sheet.getRangeByIndex(1, (i * 2) - 2, 1, (i * 2) - 1);
      }
      cell.merge();
      cell.setValue(copy[i]['nombre']);
      cell.cellStyle.backColor = copy[i]['color']!;
      cell.cellStyle.fontName = 'Arial';
      cell.cellStyle.fontSize = 12;
      cell.cellStyle.bold = true;
      cell.cellStyle.hAlign = HAlignType.center;
      cell.cellStyle.borders.all.lineStyle = LineStyle.medium;
      cell.autoFitColumns();
      cell.autoFitRows();
      if (i == 0 || i == 1 || i == 2) {
        cell.columnWidth = 14;
      }
    }
  }

  void initTotales(Workbook excel) {
    final sheet = excel.worksheets['TOTALES'];

    //Produccion
    final Range produccionRange = sheet.getRangeByName('D1:E1');
    produccionRange.merge();
    produccionRange.setValue('Producción');

    //P3L
    final Range p3LRange = sheet.getRangeByName('F1:G1');
    p3LRange.merge();
    p3LRange.setValue('P3L');

    //Complejidad
    final Range complejidadRange = sheet.getRangeByName('H1:I1');
    complejidadRange.merge();
    complejidadRange.setValue('Complejidad');

    //Puntaje
    sheet.getRangeByName('A2').setValue('ID');
    sheet.getRangeByName('B2').setValue('Edad (Meses)');
    sheet.getRangeByName('C2').setValue('Edad (Días)');
    sheet.getRangeByName('D2').setValue('Natural');
    sheet.getRangeByName('E2').setValue(' Percentil ');
    sheet.getRangeByName('F2').setValue('Natural');
    sheet.getRangeByName('G2').setValue(' Percentil ');
    sheet.getRangeByName('H2').setValue('Natural');
    sheet.getRangeByName('I2').setValue(' Percentil ');

    final completeRange = sheet.getRangeByName('A1:I2');
    completeRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleBold');
    complejidadRange.cellStyle.wrapText = false;
  }

  void guardarArchivoExcel(Workbook excel, String nombreArchivo) {
    final List<int> bytes = excel.saveSync();

    excel.dispose();

    //Download the output file in web.
    AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "$nombreArchivo.xlsx")
      ..click();
  }

  void llenarArchivoExcel(
    Workbook excel,
    List<CDI2> listaCDI2,
    List<SeccionPalabrasCDI2> seccionesPalabras,
  ) {
    for (var j = 0; j < listaCDI2.length; j++) {
      for (var seccion in seccionesPalabras) {
        seccion.asignarValores(listaCDI2[j].palabras);
      }

      for (var i = 0; i < seccionesPalabras.length; i++) {
        final palabras = seccionesPalabras[i].palabras;
        List<int> row = [];

        for (var palabra in palabras) {
          row.add(convertToInt(palabra.opcion));
        }
        final edadRecord = listaCDI2[j].edadConDiasRecord;
        excel.worksheets[i].importList(
          [listaCDI2[j].bebeId, edadRecord.meses, edadRecord.dias, ...row],
          j + 2,
          1,
          false,
        );
        row.clear();
      }

      llenarResultadosPorId(
        excel,
        seccionesPalabras,
        listaCDI2[j].bebeId,
        listaCDI2[j].edadConDiasRecord,
        j + 2,
      );
    }

    //Estilos Sheets
    for (var i = 0; i < seccionesPalabras.length; i++) {
      final palabras = seccionesPalabras[i].palabras;
      final datosRange = excel.worksheets[i].getRangeByIndex(
        2,
        1,
        listaCDI2.length + 1,
        palabras.length + 4,
      );
      datosRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
    }

    //Estilo de Resultados Por Id
    final resultadosPorIdRange = excel.worksheets['RESULTADOS POR ID'].getRangeByIndex(
      2,
      1,
      listaCDI2.length + 1,
      seccionesPalabras.length * 2 + 9,
    );
    resultadosPorIdRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
  }

  void llenarResultadosPorId(
    Workbook excel,
    List<SeccionPalabrasCDI2> seccionesPalabras,
    int bebeId,
    ({int meses, int dias}) edadRecord,
    int rowIndex,
  ) {
    final sheet = excel.worksheets['RESULTADOS POR ID'];
    final List<int> resultados = [];
    int totalComprende = 0;
    int totalComprendeYDice = 0;

    int totalComprendeICPLIM = 0;
    int totalComprendeYDiceICPLIM = 0;

    for (var seccion in seccionesPalabras) {
      int tempTotal = seccion.getTotalComprende();
      totalComprende += tempTotal;
      totalComprendeICPLIM += seccion.getTotalComprendeICPLIM();
      resultados.add(tempTotal);
      tempTotal = seccion.getTotalComprendeYDice();
      totalComprendeYDiceICPLIM += seccion.getTotalComprendeYDiceICPLIM();
      totalComprendeYDice += tempTotal;
      resultados.add(tempTotal);
    }
    resultados.add(totalComprende);
    resultados.add(totalComprendeYDice);
    resultados.add(totalComprende + totalComprendeYDice);

    sheet.importList([
      bebeId,
      edadRecord.meses,
      edadRecord.dias,
      ...resultados,
      '',
      totalComprendeICPLIM,
      totalComprendeYDiceICPLIM,
      totalComprendeICPLIM + totalComprendeYDiceICPLIM,
    ], rowIndex, 1, false);
  }

  void llenarTotales(
    Workbook excel,
    List<CDI2> listaCDI2,
  ) {
    final sheet = excel.worksheets['TOTALES'];
    for (var i = 0; i < listaCDI2.length; i++) {
      final cdi2 = listaCDI2[i];
      final puntajesProduccion = cdi2.calcularProduccion();
      final puntajesP3L = cdi2.calcularP3L();
      final puntajesComplejidad = cdi2.calcularComplejidad();
      final row = [
        puntajesProduccion.natural,
        puntajesProduccion.percentil,
        puntajesP3L.natural,
        puntajesP3L.percentil,
        puntajesComplejidad.natural,
        puntajesComplejidad.percentil,
      ];
      final edadRecord = cdi2.edadConDiasRecord;
      sheet.importList([cdi2.bebeId, edadRecord.meses, edadRecord.dias, ...row], i + 3, 1, false);
    }
    final range = sheet.getRangeByIndex(3, 1, listaCDI2.length + 2, 9);
    range.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
  }

  Future<List<SeccionPalabrasCDI2>> getSeccionesPalabras() async {
    List<SeccionPalabrasCDI2> seccionesPalabras = [];
    try {
      //Se obtienen todas las palabras divididas por seccion
      final res = await supabase.from('secciones_palabras_cdi2').select();

      seccionesPalabras = (res as List<dynamic>).map((palabra) => SeccionPalabrasCDI2.fromMap(palabra)).toList();

      return seccionesPalabras;
    } catch (e) {
      log('Error al generar archivo Excel - $e');
      return [];
    }
  }

  Future<bool> generarReporteExcel(List<CDI2> listaCDI2) async {
    final bool multiple = listaCDI2.length > 1;
    List<SeccionPalabrasCDI2> seccionesPalabras = [];

    seccionesPalabras = await getSeccionesPalabras();

    final excel = crearArchivoExcel(seccionesPalabras, multiple: multiple);

    llenarArchivoExcel(excel, listaCDI2, seccionesPalabras);

    llenarTotales(excel, listaCDI2);

    String nombreArchivo = 'resultados';

    if (!multiple) {
      nombreArchivo = listaCDI2.first.bebeId.toString();
    }

    guardarArchivoExcel(excel, nombreArchivo);

    excel.dispose();

    return true;
  }

  @override
  void dispose() {
    busquedaController.dispose();
    super.dispose();
  }
}
