import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/models/bebe.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:app_cdi/services/api_error_handler.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/custom_date_picker.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_button.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_input_field.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/input_label.dart';
import 'package:app_cdi/provider/providers.dart';

class AltaBebePopup extends StatefulWidget {
  const AltaBebePopup({
    super.key,
    this.bebeEditado,
  });

  final Bebe? bebeEditado;

  @override
  State<AltaBebePopup> createState() => _DatosBebeCardState();
}

class _DatosBebeCardState extends State<AltaBebePopup> {
  final formKey = GlobalKey<FormState>();
  bool showSexoError = false;
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    final editar = widget.bebeEditado != null;

    fToast.init(context);
    final BebesProvider provider = Provider.of<BebesProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.white,
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomCard(
          width: 600,
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
                  readOnly: editar,
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

                        if (editar) {
                          final seEditoBebe = await provider.editarBebe();
                          if (!seEditoBebe) {
                            ApiErrorHandler.callToast('Error al editar bebé');
                            return;
                          } else {
                            if (!mounted) return;
                            context.pop();
                            return;
                          }
                        }

                        final seRegistroBebe = await provider.registrarBebe();
                        if (!seRegistroBebe) {
                          ApiErrorHandler.callToast('Error al registrar bebé');
                          return;
                        } else {
                          if (!mounted) return;
                          context.pop();
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
    );
  }
}
