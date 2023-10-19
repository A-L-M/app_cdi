import 'dart:convert';
import 'dart:developer';
import 'package:universal_html/html.dart';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

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

      listadoCDI2 = (res as List<dynamic>).map((usuario) => CDI2.fromJson(jsonEncode(usuario))).toList();
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
            'edad': PlutoCell(value: cdi2.edad.toString()),
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
      {'nombre': 'TIEMPO', 'color': '#CC0000'},
      {'nombre': 'DESCRIPTIVAS', 'color': '#339966'},
      {'nombre': 'PRONOMBRES', 'color': '#33CCCC'},
      {'nombre': 'INTERROGATIVAS', 'color': '#FF6600'},
      {'nombre': 'ARTICULOS', 'color': '#660099'},
      {'nombre': 'CUANTIFICADORES', 'color': '#FFCC00'},
      {'nombre': 'LOCATIVOS', 'color': '#CCCCCC'},
      {'nombre': 'CONECTIVOS', 'color': '#CCCCCC'},
      {'nombre': 'RESULTADOS POR ID', 'color': '#FF0000'},
      //TODO: agregar
      // if (multiple) {'nombre': 'RESULTADOS POR PALABRA', 'color': '#FF0000'},
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
      idCell.cellStyle = workbook.styles.innerList.singleWhere((style) => style.name == 'StyleBold');

      final edadCell = workbook.worksheets[i].getRangeByIndex(1, 2);
      edadCell.setValue('Edad');
      edadCell.cellStyle = workbook.styles.innerList.singleWhere((style) => style.name == 'StyleBold');

      for (var j = 0; j < palabras.length; j++) {
        //se busca la celda
        final cell = workbook.worksheets[i].getRangeByIndex(1, j + 3);
        cell.setValue(palabras[j].nombre);
        cell.autoFitColumns();
        cell.autoFitRows();
        if (palabras[j].sombreada) {
          cell.cellStyle = workbook.styles.innerList.singleWhere((style) => style.name == 'StyleSombreada');
        } else if (palabras[j].subrayada && !palabras[j].sombreada) {
          cell.cellStyle = workbook.styles.innerList.singleWhere((style) => style.name == 'StyleSubrayada');
        } else {
          cell.cellStyle = workbook.styles.innerList.singleWhere((style) => style.name == 'StyleBold');
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
      {'nombre': '   Edad   ', 'color': '#FFFFFF'},
      ...nombreSheets,
      {'nombre': 'TOTAL X NIÑO', 'color': '#CCCCCC'},
      {'nombre': 'TOTAL C+C/D', 'color': '#FFFFFF'},
    ];
    copy.removeWhere((element) => element['nombre'] == 'RESULTADOS POR ID');
    copy.removeWhere((element) => element['nombre'] == 'RESULTADOS POR PALABRA');
    copy.removeWhere((element) => element['nombre'] == 'TOTALES');

    for (var i = 0; i < copy.length; i++) {
      Range cell;
      if (i == 0 || i == 1) {
        cell = sheet.getRangeByIndex(1, i + 1);
      } else {
        cell = sheet.getRangeByIndex(1, (i * 2) - 1, 1, i * 2);
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
    }
  }

  void initTotales(Workbook excel) {
    final sheet = excel.worksheets['TOTALES'];

    //Produccion
    final Range produccionRange = sheet.getRangeByName('C1:D1');
    produccionRange.merge();
    produccionRange.setValue('Producción');

    //P3L
    final Range p3LRange = sheet.getRangeByName('E1:F1');
    p3LRange.merge();
    p3LRange.setValue('P3L');

    //Complejidad
    final Range complejidadRange = sheet.getRangeByName('G1:H1');
    complejidadRange.merge();
    complejidadRange.setValue('Complejidad');

    //Puntaje
    sheet.getRangeByName('A2').setValue('ID');
    sheet.getRangeByName('B2').setValue('Edad');
    sheet.getRangeByName('C2').setValue('Natural');
    sheet.getRangeByName('D2').setValue(' Percentil ');
    sheet.getRangeByName('E2').setValue('Natural');
    sheet.getRangeByName('F2').setValue(' Percentil ');
    sheet.getRangeByName('G2').setValue('Natural');
    sheet.getRangeByName('H2').setValue(' Percentil ');

    final completeRange = sheet.getRangeByName('A1:H2');
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
        excel.worksheets[i].importList([listaCDI2[j].bebeId, listaCDI2[j].edad, ...row], j + 2, 1, false);
        row.clear();
      }

      llenarResultadosPorId(
        excel,
        seccionesPalabras,
        listaCDI2[j].bebeId,
        listaCDI2[j].edad,
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
        palabras.length + 3,
      );
      datosRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
    }

    //Estilo de Resultados Por Id
    final resultadosPorIdRange = excel.worksheets['RESULTADOS POR ID'].getRangeByIndex(
      2,
      1,
      listaCDI2.length + 1,
      seccionesPalabras.length * 2 + 5,
    );
    resultadosPorIdRange.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
  }

  void llenarResultadosPorId(
    Workbook excel,
    List<SeccionPalabrasCDI2> seccionesPalabras,
    int bebeId,
    int edad,
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
    sheet.importList([bebeId, edad, ...resultados], rowIndex, 1, false);
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
      sheet.importList([cdi2.bebeId, cdi2.edad, ...row], i + 3, 1, false);
    }
    final range = sheet.getRangeByIndex(3, 1, listaCDI2.length + 2, 8);
    range.cellStyle = excel.styles.innerList.singleWhere((style) => style.name == 'StyleDatos');
  }

  Future<List<SeccionPalabrasCDI2>> getSeccionesPalabras() async {
    List<SeccionPalabrasCDI2> seccionesPalabras = [];
    try {
      //Se obtienen todas las palabras divididas por seccion
      final res = await supabase.from('secciones_palabras_cdi2').select();

      seccionesPalabras =
          (res as List<dynamic>).map((palabra) => SeccionPalabrasCDI2.fromJson(jsonEncode(palabra))).toList();

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

  pw.Widget createTableCell(String text, {bool bold = true}) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      alignment: pw.Alignment.center,
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(fontSize: 11, fontWeight: bold ? pw.FontWeight.bold : null),
      ),
    );
  }

  Future<bool> crearPdf(CDI2 cdi2) async {
    try {
      final pdf = pw.Document();

      final theme = pw.ThemeData.withFont(
        base: pw.Font.ttf(await rootBundle.load("assets/fonts/Cambria-Regular.ttf")),
        bold: pw.Font.ttf(await rootBundle.load("assets/fonts/Cambria-Bold.ttf")),
      );

      //Imagen
      final byteData = await rootBundle.load('assets/images/logo_pdf.png');
      final imageBytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      final image = pw.MemoryImage(imageBytes);

      final produccion = cdi2.calcularProduccion();
      final p3l = cdi2.calcularP3L();
      final complejidad = cdi2.calcularComplejidad();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.letter,
          theme: theme,
          margin: const pw.EdgeInsets.symmetric(vertical: 40, horizontal: 66),
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(image, width: 190, height: 130),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(
                          "UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO",
                          style: const pw.TextStyle(fontSize: 12),
                        ),
                        pw.SizedBox(height: 7.92),
                        pw.Text(
                          "LABORATORIO DE INFANTES",
                          style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
                        ),
                        pw.SizedBox(height: 7.92),
                        pw.Text(
                          "Av. Universidad #3004, Col. Copilco-Universidad CP. 04510, Del.",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          "Coyoacán, CDMX. Facultad de Psicología, sótano edificio C.",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          "Página web: www.laboratoriodeinfantes.psicol.unam.mx",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.Text(
                          "Teléfono: 56-22-22-87 Correo: laboratorio_de_infantes@unam.mx",
                          style: const pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 10.5),
                        pw.Text(
                          "Fecha de visita: ${cdi2.createdAt.parseToString('dd/MM/yyyy')}",
                          style: const pw.TextStyle(fontSize: 10.5),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    "Estimada/o ${cdi2.cuidador}:",
                    style: const pw.TextStyle(fontSize: 10.5),
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Paragraph(
                  text:
                      '        Le agradecemos a Ud. Y a ${cdi2.nombreBebe} su colaboración con el Laboratorio de Infantes contestando el Inventario del Desarrollo de Habilidades Comunicativas MacArthur-Bates (Inventario I-II), que tiene por objetivo arrojar información confiable sobre el desarrollo lingüístico en niños mexicanos hasta los 30 meses de edad.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
                ),
                pw.Paragraph(
                  text:
                      '        Los puntajes obtenidos por ${cdi2.nombreBebe} cuando tenía ${cdi2.edad} meses han sido comparados con los puntajes de una muestra de niños de su misma edad con el fin de identificar cómo es su desarrollo de lenguaje en relación al resto de los niños. Un puntaje percentil alrededor de 50 posiciona al infante a la mitad del grupo, mostrando niveles de desarrollo típico. Los puntajes y percentiles obtenidos en el inventario se detallan a continuación:',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
                ),
                pw.Table(
                  defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                  tableWidth: pw.TableWidth.min,
                  border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
                  defaultColumnWidth: const pw.FixedColumnWidth(90),
                  children: [
                    pw.TableRow(
                      verticalAlignment: pw.TableCellVerticalAlignment.middle,
                      children: [
                        createTableCell('Sección del inventario'),
                        createTableCell('Producción de palabras'),
                        createTableCell('Combinación de palabras P3L-Palabras'),
                        createTableCell('Complejidad de frases'),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        createTableCell('Puntuación'),
                        createTableCell(produccion.natural.toString(), bold: false),
                        createTableCell(p3l.natural.toString(), bold: false),
                        createTableCell(complejidad.natural.toString(), bold: false),
                      ],
                    ),
                    pw.TableRow(
                      children: [
                        createTableCell('Percentil'),
                        createTableCell(produccion.percentil.toString(), bold: false),
                        createTableCell(p3l.percentil.toString(), bold: false),
                        createTableCell(complejidad.percentil.toString(), bold: false),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 12),
                pw.Paragraph(
                  text:
                      '        La primera sección del inventario proporciona puntuaciones de la producción de palabras de un listado de vocabulario de diferentes categorías semánticas. La siguiente sección proporciona una puntuación basada en las emisiones tempranas del infante al producir combinaciones de palabras, y la última sección está dedicada a puntuar el rango evolutivo de las frases o enunciados que reflejan la mejor manera en la que habla el infante. Estas secciones ofrecen la oportunidad de estimar un rango de habilidades tempranas de comunicación y representación que dependen de la expresión verbal.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
                ),
                pw.Paragraph(
                  text:
                      '        El Inventario es un instrumento fiable y útil en la evaluación del desarrollo del lenguaje, sin embargo, es importante mencionar que resulta insuficiente para diagnosticar posibles retrasos y/o trastornos, debido a que existen otros aspectos que podrían influir en el desarrollo de los niños y que quedan fuera del alcance de este instrumento.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
                ),
                pw.Paragraph(
                  text:
                      '        Invitamos a los padres a relacionarse con sus hijos en dinámicas de comunicación, lectura y otras interacciones conjuntas para propiciar un desarrollo típico del lenguaje.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
                ),
                pw.Paragraph(
                  text:
                      '        Para mayor información puede contactar al laboratorio en un horario de lunes a viernes de 10am a 6 pm, a través de vía telefónica, por correo o haciendo una visita directa.',
                  style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text('ATTE: ${currentUser!.nombreCompleto}'),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text('Colaborador/a del Laboratorio de Infantes'),
                ),
              ],
            ); // Center
          },
        ),
      );

      var savedFile = await pdf.save();
      List<int> fileInts = List.from(savedFile);
      AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
        ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
        ..click();
      return true;
    } catch (e) {
      log('Error al generar PDF - $e');
      return false;
    }
  }

  @override
  void dispose() {
    busquedaController.dispose();
    super.dispose();
  }
}
