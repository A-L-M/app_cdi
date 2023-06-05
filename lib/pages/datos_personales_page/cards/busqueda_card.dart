import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/datos_personales_page/widgets/datos_button.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/datos_input_field.dart';
import 'package:app_cdi/pages/datos_personales_page/widgets/input_label.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';

class BusquedaCard extends StatelessWidget {
  const BusquedaCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DatosPersonalesProvider provider =
        Provider.of<DatosPersonalesProvider>(context);
    return CustomCard(
      title: '¿Es tu segunda o tercera cita?',
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
    );
  }
}
