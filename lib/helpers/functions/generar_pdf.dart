import 'dart:convert';
import 'dart:developer';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;
import 'package:universal_html/html.dart';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

Future<bool> crearPdfCDI1(CDI1 cdi1) async {
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

    final primerasFrases = cdi1.calcularPrimerasFrases();
    final comprension = cdi1.calcularComprension();
    final produccion = cdi1.calcularProduccion();
    final totalGestos = cdi1.calcularTotalGestos();
    final gestosTempranos = cdi1.calcularGestosTempranos();
    final gestosTardios = cdi1.calcularGestosTardios();

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
                        "Teléfono: (55) 56-22-22-87 Correo: laboratorio_de_infantes@unam.mx",
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                      pw.SizedBox(height: 10.5),
                      pw.Text(
                        "Fecha de visita: ${cdi1.createdAt.parseToString('dd/MM/yyyy')}",
                        style: const pw.TextStyle(fontSize: 10.5),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Estimada/o ${cdi1.cuidador}:",
                  style: const pw.TextStyle(fontSize: 10.5),
                ),
              ),
              pw.SizedBox(height: 12),
              pw.Paragraph(
                text:
                    '        Le agradecemos a Ud. Y a ${cdi1.nombreBebe} su colaboración con el Laboratorio de Infantes contestando el Inventario del Desarrollo de Habilidades Comunicativas MacArthur-Bates (Inventario I-II), que tiene por objetivo arrojar información confiable sobre el desarrollo lingüístico en niños mexicanos hasta los 30 meses de edad.',
                style: const pw.TextStyle(fontSize: 11, lineSpacing: 1),
              ),
              pw.Paragraph(
                text:
                    '        Los puntajes obtenidos por ${cdi1.nombreBebe} cuando tenía ${cdi1.edad} meses han sido comparados con los puntajes de una muestra de niños de su misma edad con el fin de identificar cómo es su desarrollo de lenguaje en relación al resto de los niños. Un puntaje percentil alrededor de 50 posiciona al infante a la mitad del grupo, mostrando niveles de desarrollo típico. Los puntajes y percentiles obtenidos en el inventario se detallan a continuación:',
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
                      createTableCell('Primeras frases'),
                      createTableCell('Comprensión de palabras'),
                      createTableCell('Producción de palabras'),
                      createTableCell('Total de gestos'),
                      createTableCell('Gestos tempranos'),
                      createTableCell('Gestos tardíos'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      createTableCell('Puntuación'),
                      createTableCell(primerasFrases.natural.toString(), bold: false),
                      createTableCell(comprension.natural.toString(), bold: false),
                      createTableCell(produccion.natural.toString(), bold: false),
                      createTableCell(totalGestos.natural.toString(), bold: false),
                      createTableCell(gestosTempranos.natural.toString(), bold: false),
                      createTableCell(gestosTardios.natural.toString(), bold: false),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      createTableCell('Percentil'),
                      createTableCell(primerasFrases.percentil.toString(), bold: false),
                      createTableCell(comprension.percentil.toString(), bold: false),
                      createTableCell(produccion.percentil.toString(), bold: false),
                      createTableCell(totalGestos.percentil.toString(), bold: false),
                      createTableCell(gestosTempranos.percentil.toString(), bold: false),
                      createTableCell(gestosTardios.percentil.toString(), bold: false),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Paragraph(
                text:
                    '        La primera sección del inventario estima la comprensión del infante hacia frases que pudieran ser frecuentes en su contexto de desarrollo desde edades tempranas. Las siguientes dos secciones proporcionan puntuaciones de la comprensión y producción de palabras de un listado de vocabulario de diferentes categorías semánticas. Las últimas tres secciones están dedicadas al uso de gestos comunicativos y simbólicos por parte del niño. Estas secciones ofrecen la oportunidad de estimar un rango de habilidades tempranas de comunicación y representación que no dependen de la expresión verbal.',
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

Future<bool> crearPdfCDI2(CDI2 cdi2) async {
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
                        "Teléfono: (55) 56-22-22-87 Correo: laboratorio_de_infantes@unam.mx",
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
