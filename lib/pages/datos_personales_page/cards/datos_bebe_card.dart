import 'package:app_cdi/pages/datos_personales_page/widgets/custom_card.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/custom_date_picker.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_button.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_input_field.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/input_label.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final DatosPersonalesProvider provider =
        Provider.of<DatosPersonalesProvider>(context);

    return CustomCard(
      title: 'Datos del bebé',
      height: 765,
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
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    if (widget.inventario == 'INVENTARIO I') {
                      context.pushReplacement('/cdi-1');
                    } else {
                      context.pushReplacement('/cdi-2');
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
