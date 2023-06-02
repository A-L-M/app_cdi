import 'package:app_cdi/pages/datos_personales_page/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/custom_card.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_header.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_input_field.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/input_label.dart';
import 'package:app_cdi/provider/providers.dart';

class DatosPersonalesPage extends StatefulWidget {
  const DatosPersonalesPage({
    Key? key,
    required this.inventario,
  }) : super(key: key);

  final String inventario;

  @override
  State<DatosPersonalesPage> createState() => _DatosPersonalesPageState();
}

class _DatosPersonalesPageState extends State<DatosPersonalesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > mobileSize) {
            return DatosPersonalesDesktop(inventario: widget.inventario);
          } else {
            return DatosPersonalesMobile(inventario: widget.inventario);
          }
        }),
      ),
    );
  }
}

class DatosPersonalesDesktop extends StatefulWidget {
  const DatosPersonalesDesktop({
    Key? key,
    required this.inventario,
  }) : super(key: key);

  final String inventario;

  @override
  State<DatosPersonalesDesktop> createState() => _DatosPersonalesDesktopState();
}

class _DatosPersonalesDesktopState extends State<DatosPersonalesDesktop> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final DatosPersonalesProvider provider =
        Provider.of<DatosPersonalesProvider>(context);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const DatosHeader(),
            SizedBox(
              width: 1170,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          CustomCard(
                            title: 'Palabras y Enunciados',
                            height: 191.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    '(${widget.inventario})',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2B2B2B),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Donna Jackson - Maldonado, PhD',
                                        style: GoogleFonts.robotoSlab(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Elizabeth Bates, PhD y Donna J. Thal, PhD',
                                        style: GoogleFonts.robotoSlab(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomCard(
                            title: '¿Es tu segunda o tercera cita?',
                            height: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const InputLabel(label: 'Buscar bebé'),
                                DatosInputField(
                                  label: 'Número de identificación',
                                  controller: provider.buscarController,
                                  textInputType: TextInputType.text,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'),
                                    ),
                                  ],
                                ),
                                Text('Buscar'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomCard(
                        title: 'Datos del bebé',
                        height: 717.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const InputLabel(label: 'Número de identificación'),
                            DatosInputField(
                              label: 'Número de identificación',
                              controller: provider.numIdentificacionController,
                              textInputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El número de identificación es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const InputLabel(
                              label: 'Nombre completo del cuidador',
                            ),
                            DatosInputField(
                              label: 'Nombre completo del cuidador',
                              controller: provider.nombreCuidadorController,
                              textInputType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"^[a-zA-ZÀ-ÿ´ ]+"),
                                )
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre completo del cuidador es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const InputLabel(label: 'Nombre(s)'),
                            DatosInputField(
                              label: 'Nombre(s)',
                              controller: provider.nombreController,
                              textInputType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"^[a-zA-ZÀ-ÿ´ ]+"),
                                )
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El nombre es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const InputLabel(label: 'Apellido paterno'),
                            DatosInputField(
                              label: 'Apellido paterno',
                              controller: provider.apellidoPaternoController,
                              textInputType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"^[a-zA-ZÀ-ÿ´ ]+"),
                                )
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'El apellido es obligatorio';
                                }
                                return null;
                              },
                            ),
                            const InputLabel(label: 'Apellido materno'),
                            DatosInputField(
                              label: 'Apellido materno',
                              controller: provider.apellidoMaternoController,
                              textInputType: TextInputType.text,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r"^[a-zA-ZÀ-ÿ´ ]+"),
                                )
                              ],
                            ),
                            const InputLabel(label: 'Sexo'),
                            const InputLabel(label: 'Fecha de nacimiento'),
                            CustomDatePicker(onChange: (date) {
                              if (date == null) return;
                              provider.fechaNacimiento = date;
                            }),
                            const InputLabel(label: 'Fecha de la cita'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatosPersonalesMobile extends StatefulWidget {
  const DatosPersonalesMobile({
    Key? key,
    required this.inventario,
  }) : super(key: key);

  final String inventario;

  @override
  State<DatosPersonalesMobile> createState() => _DatosPersonalesMobileState();
}

class _DatosPersonalesMobileState extends State<DatosPersonalesMobile> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
