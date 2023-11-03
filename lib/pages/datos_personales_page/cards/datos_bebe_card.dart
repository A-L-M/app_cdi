import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/models/bebe.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/custom_date_picker.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_button.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_input_field.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/input_label.dart';
import 'package:app_cdi/provider/providers.dart';

class DatosBebeCard extends StatefulWidget {
  const DatosBebeCard({
    super.key,
    required this.inventario,
  });

  final String inventario;

  @override
  State<DatosBebeCard> createState() => _DatosBebeCardState();
}

class _DatosBebeCardState extends State<DatosBebeCard> {
  final formKey = GlobalKey<FormState>();
  bool showSexoError = false;
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    final DatosPersonalesProvider provider = Provider.of<DatosPersonalesProvider>(context);

    return CustomCard(
      title: 'Datos del bebé',
      child: Form(
        key: formKey,
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
            Row(
              children: [
                Expanded(
                  child: RadioListTile<Sexo>(
                    title: const Text('Hombre'),
                    activeColor: AppTheme.of(context).secondaryColor,
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
                    activeColor: AppTheme.of(context).secondaryColor,
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
            if (showSexoError)
              Text(
                'El sexo es obligatorio',
                style: GoogleFonts.robotoSlab(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
            const SizedBox(height: 10),
            const InputLabel(label: 'Fecha de nacimiento'),
            CustomDatePicker(
              initialDate: provider.fechaNacimiento,
              controller: provider.fechaNacimientoController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]/'),
                ),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La fecha de nacimiento es obligatoria';
                }
                return null;
              },
              onChanged: (date) {
                if (date == null) return;
                provider.fechaNacimiento = date;
              },
            ),
            const InputLabel(label: 'Fecha de la cita'),
            CustomDatePicker(
              initialDate: DateTime.now(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]/'),
                ),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La fecha de la cita es obligatoria';
                }
                return null;
              },
              onChanged: (date) {
                if (date == null) return;
                provider.fechaCita = date;
              },
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
                  onTap: () async {
                    if (!formKey.currentState!.validate()) {
                      if (provider.sexo == null) {
                        showSexoError = true;
                        setState(() {});
                        return;
                      } else {
                        showSexoError = false;
                        setState(() {});
                      }
                      return;
                    }
                    provider.id = provider.numIdentificacionController.text;

                    final seRegistroBebe = await provider.registrarBebe();

                    if (!seRegistroBebe) {
                      ApiErrorHandler.callToast('Error al registrar bebé');
                      return;
                    }

                    if (widget.inventario == 'INVENTARIO I') {
                      final res = await provider.registrarCDI1();
                      if (res['Error'] != null) {
                        ApiErrorHandler.callToast(res['Error']);
                        return;
                      }
                      final cdi1Id = res['cdi_id'];
                      if (!mounted) return;
                      context.pushReplacement('/cdi-1/$cdi1Id');
                    } else {
                      final res = await provider.registrarCDI2();
                      if (res['Error'] != null) {
                        ApiErrorHandler.callToast(res['Error']);
                        return;
                      }
                      final cdi2Id = res['cdi_id'];
                      if (!mounted) return;
                      context.pushReplacement('/cdi-2/$cdi2Id');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
