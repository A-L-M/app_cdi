import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart';

import 'package:app_cdi/helpers/functions/remove_diacritics.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/helpers/datetime_extension.dart';

class ListadoCDI1Provider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<CDI1> listadoCDI1 = [];
  List<CDI1> listadoCDI1Filtrado = [];

  CDI2? cdi1Editado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "cdi1_id";

  Future<void> updateState() async {
    await getListadoCDI1();
  }

  Future<void> getListadoCDI1() async {
    try {
      final res = await supabase.from('cdi1_completo').select().order(orden, ascending: false);

      if (res == null) {
        log('Error en getListadoCDI1()');
        return;
      }

      listadoCDI1 = (res as List<dynamic>).map((usuario) => CDI1.fromMap(usuario)).toList();
      listadoCDI1Filtrado = [...listadoCDI1];

      llenarPlutoGrid(listadoCDI1);
    } catch (e) {
      log('Error en getListadoCDI1() - $e');
    }
  }

  void llenarPlutoGrid(List<CDI1> listadoCDI1) {
    rows.clear();
    listadoCDI1Filtrado = [...listadoCDI1];
    for (CDI1 cdi1 in listadoCDI1) {
      rows.add(
        PlutoRow(
          cells: {
            'cdi1_id': PlutoCell(value: cdi1.cdi1Id),
            'bebe_id': PlutoCell(value: cdi1.bebeId),
            'nombre_bebe': PlutoCell(value: cdi1.nombreBebe),
            'edad': PlutoCell(value: cdi1.edadConDias),
            'created_at': PlutoCell(value: cdi1.createdAt.parseToString('yyyy-MM-dd')),
            'acciones': PlutoCell(value: cdi1.cdi1Id.toString()),
          },
        ),
      );
    }
    if (stateManager != null) stateManager!.notifyListeners();
    notifyListeners();
  }

  void filtrarCDI1() {
    //Revisar que exista busqueda
    if (busquedaController.text.isEmpty) {
      listadoCDI1Filtrado = [...listadoCDI1];
      llenarPlutoGrid(listadoCDI1Filtrado);
      return;
    }

    //Revisar que se este buscando un id
    final int? id = int.tryParse(busquedaController.text);
    if (id != null) {
      listadoCDI1Filtrado =
          listadoCDI1.where((registro) => registro.bebeId.toString().contains(id.toString())).toList();
      llenarPlutoGrid(listadoCDI1Filtrado);
      return;
    }

    //Revisar que se este buscando un nombre
    final String busqueda = removeDiacritics(busquedaController.text).toLowerCase();
    listadoCDI1Filtrado = listadoCDI1.where((registro) {
      final String nombreBebe = removeDiacritics(registro.nombreBebe).toLowerCase();
      if (nombreBebe.contains(busqueda)) return true;
      return false;
    }).toList();

    llenarPlutoGrid(listadoCDI1Filtrado);
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

  Workbook crearArchivoExcel(
    List<SeccionPalabrasCDI1> seccionesPalabras, {
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
      {'nombre': 'PREPOSICIONES', 'color': '#CCCCCC'},
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

    final CellStyle styleDatos = CellStyle(workbook, 'StyleDatos');
    styleDatos.fontName = 'Arial';
    styleDatos.fontSize = 12;
    styleDatos.hAlign = HAlignType.center;
    styleDatos.wrapText = true;

    workbook.styles.addStyle(styleBold);
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
        cell.cellStyle = styleBold;
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
      {'nombre': 'ID', 'color': '#FFFFFF'},
      {'nombre': 'Edad (Meses)', 'color': '#FFFFFF'},
      {'nombre': 'Edad (Días)', 'color': '#FFFFFF'},
      ...nombreSheets,
      {'nombre': 'TOTAL X NIÑO', 'color': '#CCCCCC'},
      {'nombre': 'TOTAL C+C/D', 'color': '#FFFFFF'},
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

    //Comprension primeras frases
    final Range primerasFrasesRange = sheet.getRangeByName('D1:E1');
    primerasFrasesRange.merge();
    primerasFrasesRange.setValue('Comprensión Primeras Frases');

    //Comprension
    final Range comprensionRange = sheet.getRangeByName('F1:G1');
    comprensionRange.merge();
    comprensionRange.setValue('Comprensión');

    //Produccion
    final Range produccionRange = sheet.getRangeByName('H1:I1');
    produccionRange.merge();
    produccionRange.setValue('Producción');

    //Total Gestos
    final Range totalGestosRange = sheet.getRangeByName('J1:K1');
    totalGestosRange.merge();
    totalGestosRange.setValue('Total Gestos');

    //Gestos Tempranos
    final Range gestosTempranosRange = sheet.getRangeByName('L1:M1');
    gestosTempranosRange.merge();
    gestosTempranosRange.setValue('Gestos Tempranos');

    //Gestos Tardios
    final Range gestosTardiosRange = sheet.getRangeByName('N1:O1');
    gestosTardiosRange.merge();
    gestosTardiosRange.setValue('Gestos Tardíos');

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
    sheet.getRangeByName('J2').setValue('Natural');
    sheet.getRangeByName('K2').setValue(' Percentil ');
    sheet.getRangeByName('L2').setValue('Natural');
    sheet.getRangeByName('M2').setValue(' Percentil ');
    sheet.getRangeByName('N2').setValue('Natural');
    sheet.getRangeByName('O2').setValue(' Percentil ');

    final completeRange = sheet.getRangeByName('A1:O2');
    completeRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleBold');
    gestosTardiosRange.cellStyle.wrapText = false;

    sheet.getRangeByName('B2').columnWidth = 14;
    sheet.getRangeByName('C2').columnWidth = 12;
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
    List<CDI1> listaCDI1,
    List<SeccionPalabrasCDI1> seccionesPalabras,
  ) {
    for (var j = 0; j < listaCDI1.length; j++) {
      for (var seccion in seccionesPalabras) {
        seccion.asignarValores(listaCDI1[j].palabras);
      }

      for (var i = 0; i < seccionesPalabras.length; i++) {
        final palabras = seccionesPalabras[i].palabras;
        List<int> row = [];

        for (var palabra in palabras) {
          row.add(convertToInt(palabra.opcion));
        }
        final edadRecord = listaCDI1[j].edadConDiasRecord;
        excel.worksheets[i].importList([
          listaCDI1[j].bebeId,
          edadRecord.meses,
          edadRecord.dias,
          ...row,
        ], j + 2, 1, false);
        row.clear();
      }

      llenarResultadosPorId(
        excel,
        seccionesPalabras,
        listaCDI1[j].bebeId,
        listaCDI1[j].edadConDiasRecord,
        j + 2,
      );
    }

    //Estilos Sheets
    for (var i = 0; i < seccionesPalabras.length; i++) {
      final palabras = seccionesPalabras[i].palabras;
      final datosRange = excel.worksheets[i].getRangeByIndex(
        2,
        1,
        listaCDI1.length + 1,
        palabras.length + 3,
      );
      datosRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
    }

    //Estilo de Resultados Por Id
    final resultadosPorIdRange = excel.worksheets['RESULTADOS POR ID'].getRangeByIndex(
      2,
      1,
      listaCDI1.length + 1,
      seccionesPalabras.length * 2 + 6,
    );
    resultadosPorIdRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
  }

  void llenarResultadosPorId(
    Workbook excel,
    List<SeccionPalabrasCDI1> seccionesPalabras,
    int bebeId,
    ({int meses, int dias}) edadRecord,
    int rowIndex,
  ) {
    final sheet = excel.worksheets['RESULTADOS POR ID'];
    final List<int> resultados = [];
    int totalComprende = 0;
    int totalComprendeYDice = 0;
    for (var seccion in seccionesPalabras) {
      int tempTotal = seccion.getTotalComprende();
      totalComprende += tempTotal;
      resultados.add(tempTotal);
      tempTotal = seccion.getTotalComprendeYDice();
      totalComprendeYDice += tempTotal;
      resultados.add(tempTotal);
    }
    resultados.add(totalComprende);
    resultados.add(totalComprendeYDice);
    resultados.add(totalComprende + totalComprendeYDice);
    sheet.importList([bebeId, edadRecord.meses, edadRecord.dias, ...resultados], rowIndex, 1, false);
  }

  void llenarTotales(
    Workbook excel,
    List<CDI1> listaCDI1,
  ) {
    final sheet = excel.worksheets['TOTALES'];
    for (var i = 0; i < listaCDI1.length; i++) {
      final cdi1 = listaCDI1[i];
      final puntajesPrimerasFrases = cdi1.calcularPrimerasFrases();
      final puntajesComprension = cdi1.calcularComprension();
      final puntajesProduccion = cdi1.calcularProduccion();
      final puntajesTotalGestos = cdi1.calcularTotalGestos();
      final puntajesGestosTempranos = cdi1.calcularGestosTempranos();
      final puntajesGestosTardios = cdi1.calcularGestosTardios();
      final row = [
        puntajesPrimerasFrases.natural,
        puntajesPrimerasFrases.percentil,
        puntajesComprension.natural,
        puntajesComprension.percentil,
        puntajesProduccion.natural,
        puntajesProduccion.percentil,
        puntajesTotalGestos.natural,
        puntajesTotalGestos.percentil,
        puntajesGestosTempranos.natural,
        puntajesGestosTempranos.percentil,
        puntajesGestosTardios.natural,
        puntajesGestosTardios.percentil,
      ];
      final edadRecord = cdi1.edadConDiasRecord;
      sheet.importList([cdi1.bebeId, edadRecord.meses, edadRecord.dias, ...row], i + 3, 1, false);
    }
    final range = sheet.getRangeByIndex(3, 1, listaCDI1.length + 2, 16);
    range.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
  }

  Future<List<SeccionPalabrasCDI1>> getSeccionesPalabras() async {
    List<SeccionPalabrasCDI1> seccionesPalabras = [];
    try {
      //Se obtienen todas las palabras divididas por seccion
      final res = await supabase.from('secciones_palabras_cdi1').select();

      seccionesPalabras = (res as List<dynamic>).map((palabra) => SeccionPalabrasCDI1.fromMap(palabra)).toList();

      return seccionesPalabras;
    } catch (e) {
      log('Error al generar archivo Excel - $e');
      return [];
    }
  }

  Future<bool> generarReporteExcel(List<CDI1> listaCDI1) async {
    final bool multiple = listaCDI1.length > 1;
    List<SeccionPalabrasCDI1> seccionesPalabras = [];

    seccionesPalabras = await getSeccionesPalabras();

    final excel = crearArchivoExcel(seccionesPalabras, multiple: multiple);

    llenarArchivoExcel(excel, listaCDI1, seccionesPalabras);

    llenarTotales(excel, listaCDI1);

    String nombreArchivo = 'resultados';

    if (!multiple) {
      nombreArchivo = listaCDI1.first.bebeId.toString();
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
