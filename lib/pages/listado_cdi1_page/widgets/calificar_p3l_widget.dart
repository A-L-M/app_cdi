import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/pages/widgets/custom_button.dart';
import 'package:app_cdi/pages/widgets/popup.dart';
import 'package:app_cdi/provider/listado_cdi2_provider.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CalificarP3LWidget extends StatefulWidget {
  const CalificarP3LWidget({
    super.key,
    required this.cdi2,
  });

  final CDI2 cdi2;

  @override
  State<CalificarP3LWidget> createState() => _CalificarP3LWidgetState();
}

class _CalificarP3LWidgetState extends State<CalificarP3LWidget> {
  TextEditingController ejemplo1CalificacionController =
      TextEditingController();
  TextEditingController ejemplo2CalificacionController =
      TextEditingController();
  TextEditingController ejemplo3CalificacionController =
      TextEditingController();

  bool hayEjemplos = true;
  double promedio = 0.0;

  String ejemplo1 = '';
  String ejemplo2 = '';
  String ejemplo3 = '';

  int? cal1;
  int? cal2;
  int? cal3;

  @override
  void initState() {
    ejemplo1 = widget.cdi2.parte2.ejemplo1 ?? '';
    ejemplo2 = widget.cdi2.parte2.ejemplo2 ?? '';
    ejemplo3 = widget.cdi2.parte2.ejemplo3 ?? '';

    cal1 = widget.cdi2.parte2.ejemplo1Calificacion;
    cal2 = widget.cdi2.parte2.ejemplo2Calificacion;
    cal3 = widget.cdi2.parte2.ejemplo3Calificacion;

    if (ejemplo1.isEmpty && ejemplo2.isEmpty && ejemplo3.isEmpty) {
      hayEjemplos = false;
      super.initState();
      return;
    }

    setPromedio();

    if (cal1 != null) {
      ejemplo1CalificacionController.text = cal1.toString();
    }

    if (cal2 != null) {
      ejemplo2CalificacionController.text = cal2.toString();
    }

    if (cal3 != null) {
      ejemplo3CalificacionController.text = cal3.toString();
    }

    super.initState();
  }

  void setPromedio() {
    double numEjemplos = 0;

    if (ejemplo1.isNotEmpty) {
      numEjemplos += 1;
    }

    if (ejemplo2.isNotEmpty) {
      numEjemplos += 1;
    }

    if (ejemplo3.isNotEmpty) {
      numEjemplos += 1;
    }

    if (numEjemplos != 0) {
      promedio = ((cal1?.toDouble() ?? 0.0) +
              (cal2?.toDouble() ?? 0.0) +
              (cal3?.toDouble() ?? 0.0)) /
          numEjemplos;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ListadoCDI2Provider provider =
        Provider.of<ListadoCDI2Provider>(context, listen: false);

    if (!hayEjemplos) {
      return Popup(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Calificar P3L',
                    style: AppTheme.of(context).title1.override(
                        fontFamily: 'DroidSerif-Regular',
                        color: AppTheme.of(context).primaryColor,
                        fontSize: 35,
                        useGoogleFonts: false,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: AppTheme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'El inventario no contiene frases para calificar.',
                style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Popup(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Calificar P3L',
                    style: AppTheme.of(context).title1.override(
                        fontFamily: 'DroidSerif-Regular',
                        color: AppTheme.of(context).primaryColor,
                        fontSize: 35,
                        useGoogleFonts: false,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: AppTheme.of(context).primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ejemplo1.isNotEmpty)
                    EjemploField(
                      number: '1',
                      texto: ejemplo1,
                      controller: ejemplo1CalificacionController,
                      onChanged: (value) {
                        cal1 = int.tryParse(value);
                        setPromedio();
                        setState(() {});
                      },
                    ),
                  if (ejemplo2.isNotEmpty)
                    EjemploField(
                      number: '2',
                      texto: ejemplo2,
                      controller: ejemplo2CalificacionController,
                      onChanged: (value) {
                        cal2 = int.tryParse(value);
                        setPromedio();
                        setState(() {});
                      },
                    ),
                  if (ejemplo3.isNotEmpty)
                    EjemploField(
                      number: '3',
                      texto: ejemplo3,
                      controller: ejemplo3CalificacionController,
                      onChanged: (value) {
                        cal3 = int.tryParse(value);
                        setPromedio();
                        setState(() {});
                      },
                    ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Promedio: ',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        promedio.toStringAsFixed(2),
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
              child: CustomButton(
                onPressed: () async {
                  final res = await provider.calificarP3L(
                      widget.cdi2.cdi2Id, cal1, cal2, cal3);
                  if (!mounted) return;
                  Navigator.pop(context, res);
                },
                text: 'Calificar',
                options: ButtonOptions(
                  width: 125,
                  padding: const EdgeInsets.all(20),
                  color: AppTheme.of(context).primaryColor,
                  textStyle: AppTheme.of(context).subtitle2.override(
                        fontFamily: 'Gotham-Bold',
                        color: AppTheme.of(context).secondaryBackground,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        useGoogleFonts: false,
                      ),
                  elevation: 2,
                  borderSide: BorderSide(
                    color: AppTheme.of(context).primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class EjemploField extends StatelessWidget {
  const EjemploField({
    super.key,
    required this.number,
    required this.texto,
    required this.controller,
    required this.onChanged,
  });

  final String number;
  final String texto;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number. ',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              texto,
              maxLines: 2,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SizedBox(
              height: 30,
              width: 30,
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Se debe calificar la frase';
                  }
                  return null;
                },
                onChanged: onChanged,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]'),
                  ),
                ],
                decoration: InputDecoration(
                  isCollapsed: true,
                  isDense: true,
                  contentPadding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: 10,
                    bottom: 10,
                  ),
                  alignLabelWithHint: true,
                  errorStyle: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.normal,
                    color: Colors.red,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFCCCCCC),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.88),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.88),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.88),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(4.88),
                  ),
                  focusColor: AppTheme.of(context).primaryColor,
                ),
                style: GoogleFonts.robotoSlab(
                  color: const Color(0xFF2B2B2B),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
