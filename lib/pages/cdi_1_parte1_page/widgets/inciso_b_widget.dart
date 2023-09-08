import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';

class IncisoBWidget extends StatefulWidget {
  const IncisoBWidget({super.key});

  @override
  State<IncisoBWidget> createState() => _IncisoBWidgetState();
}

class _IncisoBWidgetState extends State<IncisoBWidget> {
  List<String> frasesCompletas = [
    'abre la boca',
    'adiós',
    'a domir/hacer la meme',
    'aviéntala/lo',
    'bravo',
    'cuidado',
    'dame/dale',
    '¿dónde está el gua-guá?',
    'estate quieto',
    'hazme ojitos',
    'mira',
    'muy bien',
    'no',
    'no te muevas',
    'no toques eso',
    'párate',
    '¿quieres leche?',
    '¿quieres más?',
    'sácalo',
    'siéntate',
    'silencio',
    '¿te cambio el pañal?',
    '¿tienes hambre?',
    'tráeme eso',
    'vámonos',
    'ven',
    'ya',
    'ya llegó papá/mamá',
  ];

  @override
  Widget build(BuildContext context) {
    final CDI1Provider provider = Provider.of<CDI1Provider>(
      context,
      listen: false,
    );
    final size = MediaQuery.of(context).size;

    //numero de columnas
    int numColumnas = 4;

    if (size.width > 1145) {
      numColumnas = 4;
    } else if (size.width > 859) {
      numColumnas = 3;
    } else if (size.width > 573) {
      numColumnas = 2;
    } else {
      numColumnas = 1;
    }

    final List<_FraseWidget> frases = List.generate(
      provider.parte1.listaFrases.length,
      (index) {
        return _FraseWidget(
          index: index,
          frase: frasesCompletas[index],
          valor: provider.parte1.listaFrases[index],
        );
      },
    );

    final int numRenglones = (frases.length / numColumnas).ceil();

    List<Column> columnas = [];

    for (var i = 0; i < numColumnas; i++) {
      int startIndex = i * numRenglones;
      int finalIndex = startIndex + numRenglones;
      if (i == numColumnas - 1) finalIndex = frases.length;
      final columna = Column(
        children: frases.sublist(startIndex, finalIndex),
      );
      columnas.add(columna);
    }

    return CustomCard(
      title: 'B. Comprensión de las primeras frases',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'En la lista que viene a continuación, por favor, rellene el círculo que corresponda a las frases que su hijo(a) comprende.',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: columnas,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _FraseWidget extends StatefulWidget {
  const _FraseWidget({
    Key? key,
    required this.index,
    required this.frase,
    required this.valor,
  }) : super(key: key);

  final int index;
  final String frase;
  final bool valor;

  @override
  State<_FraseWidget> createState() => __FraseWidgetState();
}

class __FraseWidgetState extends State<_FraseWidget> {
  bool isChecked = false;

  @override
  void initState() {
    isChecked = widget.valor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('isChecked = $isChecked');
    print('valor = ${widget.valor}');
    final size = MediaQuery.of(context).size;

    final CDI1Provider provider = Provider.of<CDI1Provider>(
      context,
      listen: false,
    );

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDDDDD),
        ),
      ),
      width: size.width > 865 ? 278 : 250,
      height: 50,
      child: ListTile(
        title: Text(
          widget.frase,
          style: GoogleFonts.robotoSlab(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: const Color(0xFF2B2B2B),
          ),
        ),
        trailing: Checkbox(
          checkColor: AppTheme.of(context).secondaryColor,
          // fillColor: MaterialStateProperty.resolveWith<Color>(
          //     (_) => AppTheme.of(context).secondaryColor),
          value: isChecked,
          shape: const CircleBorder(),
          onChanged: (bool? value) {
            if (value == null) return;
            provider.setFraseIncisoB(widget.index, value);
            setState(() {
              isChecked = value;
            });
          },
        ),
      ),
    );
  }
}
