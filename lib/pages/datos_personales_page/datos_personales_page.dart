import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/datos_personales_page/cards/title_card.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/custom_date_picker.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_button.dart';
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
                          TitleCard(inventario: widget.inventario),
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
                                Align(
                                  child: DatosButton(
                                    label: 'BUSCAR',
                                    onTap: () {},
                                  ),
                                ),
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
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: RadioListTile<Sexo>(
                                      title: const Text('Hombre'),
                                      activeColor: const Color(0xFF002976),
                                      value: Sexo.hombre,
                                      groupValue: provider.sexo,
                                      onChanged: (sexo) {
                                        if (sexo == null) return;
                                        provider.setSexo(sexo);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile<Sexo>(
                                      title: const Text('Mujer'),
                                      activeColor: const Color(0xFF002976),
                                      value: Sexo.mujer,
                                      groupValue: provider.sexo,
                                      onChanged: (sexo) {
                                        if (sexo == null) return;
                                        provider.setSexo(sexo);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const InputLabel(label: 'Fecha de nacimiento'),
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: CustomDatePicker(onChanged: (date) {
                                if (date == null) return;
                                provider.fechaNacimiento = date;
                              }),
                            ),
                            const InputLabel(label: 'Fecha de la cita'),
                            Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              child: CustomDatePicker(
                                initialDate: DateTime.now(),
                                onChanged: (date) {
                                  if (date == null) return;
                                  provider.fechaCita = date;
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DatosButton(
                                  label: 'LIMPIAR',
                                  onTap: () {
                                    provider.clearAll();
                                  },
                                ),
                                const SizedBox(width: 20),
                                DatosButton(
                                  label: 'CONTINUAR',
                                  onTap: () {
                                    if (widget.inventario == 'INVENTARIO I') {
                                      context.pushReplacement('/cdi-1');
                                    } else {
                                      context.pushReplacement('cdi-2');
                                    }
                                  },
                                ),
                              ],
                            ),
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
