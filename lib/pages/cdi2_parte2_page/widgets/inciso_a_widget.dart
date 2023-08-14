import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';

class IncisoAWidget extends StatefulWidget {
  const IncisoAWidget({super.key});

  @override
  State<IncisoAWidget> createState() => _IncisoAWidgetState();
}

class _IncisoAWidgetState extends State<IncisoAWidget> {
  @override
  Widget build(BuildContext context) {
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);
    final size = MediaQuery.of(context).size;

    //numero de columnas
    int numColumnas = 3;

    if (size.width > 1145) {
      numColumnas = 3;
    } else if (size.width > 857) {
      numColumnas = 2;
    } else {
      numColumnas = 1;
    }

    //PRESENTE
    final List<_VerboWidget> presente = [
      _VerboWidget(
        verbo: 'Acabo',
        valor: provider.parte2.acabo,
        onChanged: (bool value) => provider.parte2.acabo = value,
      ),
      _VerboWidget(
        verbo: 'Acabas',
        valor: provider.parte2.acabas,
        onChanged: (bool value) => provider.parte2.acabas = value,
      ),
      _VerboWidget(
        verbo: 'Acaba',
        valor: provider.parte2.acaba,
        onChanged: (bool value) => provider.parte2.acaba = value,
      ),
      _VerboWidget(
        verbo: 'Acabamos',
        valor: provider.parte2.acabamos,
        onChanged: (bool value) => provider.parte2.acabamos = value,
      ),
      _VerboWidget(
        verbo: 'Como',
        valor: provider.parte2.como,
        onChanged: (bool value) => provider.parte2.como = value,
      ),
      _VerboWidget(
        verbo: 'Comes',
        valor: provider.parte2.comes,
        onChanged: (bool value) => provider.parte2.comes = value,
      ),
      _VerboWidget(
        verbo: 'Come',
        valor: provider.parte2.come,
        onChanged: (bool value) => provider.parte2.come = value,
      ),
      _VerboWidget(
        verbo: 'Comemos',
        valor: provider.parte2.comemos,
        onChanged: (bool value) => provider.parte2.comemos = value,
      ),
      _VerboWidget(
        verbo: 'Subo',
        valor: provider.parte2.subo,
        onChanged: (bool value) => provider.parte2.subo = value,
      ),
      _VerboWidget(
        verbo: 'Subes',
        valor: provider.parte2.subes,
        onChanged: (bool value) => provider.parte2.subes = value,
      ),
      _VerboWidget(
        verbo: 'Sube',
        valor: provider.parte2.sube,
        onChanged: (bool value) => provider.parte2.sube = value,
      ),
      _VerboWidget(
        verbo: 'Subimos',
        valor: provider.parte2.subimos,
        onChanged: (bool value) => provider.parte2.subimos = value,
      ),
    ];

    final int numRenglonesPresente = (presente.length / numColumnas).ceil();

    List<Column> columnasPresente = [];

    for (var i = 0; i < numColumnas; i++) {
      int startIndex = i * numRenglonesPresente;
      int finalIndex = startIndex + numRenglonesPresente;
      if (i == numColumnas - 1) finalIndex = presente.length;
      final columna = Column(
        children: presente.sublist(startIndex, finalIndex),
      );
      columnasPresente.add(columna);
    }

    //PASADO

    //PRESENTE

    return CustomCard(
      title: 'A. Formas de verbos',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'A continuación encontrará una lista de diferentes terminaciones de verbos. Indique si su hijo(a) usa palabras de la lista. En caso de que no utilice la misma palabra, pero que use la misma terminación con palabras similares, por favor, rellene el círculo de la palabra que más se le parezca. Por ejemplo, si en vez de "comes" dice "duermes" o "puedes", marque la línea de "comes"',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Para hablar de lo que sucede en el presente, ¿Cuáles de estas formas usa?',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: columnasPresente,
          ),
        ],
      ),
    );
  }
}

class _VerboWidget extends StatefulWidget {
  const _VerboWidget({
    Key? key,
    required this.verbo,
    this.valor = false,
    required this.onChanged,
  }) : super(key: key);

  final String verbo;
  final bool? valor;
  final void Function(bool) onChanged;

  @override
  State<_VerboWidget> createState() => __VerboWidgetState();
}

class __VerboWidgetState extends State<_VerboWidget> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.valor ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
      ),
      width: size.width > 865 ? 371 : 250,
      height: 50,
      child: ListTile(
        title: Text(
          widget.verbo,
          style: GoogleFonts.robotoSlab(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF2B2B2B),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              checkColor: AppTheme.of(context).secondaryColor,
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (_) => AppTheme.of(context).secondaryColor),
              value: isChecked,
              shape: const CircleBorder(),
              onChanged: (bool? value) {
                if (value == null) return;
                widget.onChanged(value);
                setState(() {
                  isChecked = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
