import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/cdi_2_provider.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IncisoCWidget extends StatefulWidget {
  const IncisoCWidget({super.key});

  @override
  State<IncisoCWidget> createState() => _IncisoCWidgetState();
}

class _IncisoCWidgetState extends State<IncisoCWidget> {
  @override
  Widget build(BuildContext context) {
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);
    final size = MediaQuery.of(context).size;

    //numero de columnas
    int numColumnas = 4;

    if (size.width > 1145) {
      numColumnas = 4;
    } else if (size.width > 834) {
      numColumnas = 3;
    } else if (size.width > 573) {
      numColumnas = 2;
    } else {
      numColumnas = 1;
    }

    //Lista de widgets
    final List<_ComplejidadWidget> frases = [
      _ComplejidadWidget(
        numero: '1',
        frase1: 'Nene quiere',
        frase2: 'Quiero paleta',
        groupValue: provider.parte2.complejidad1,
        onChanged: (value) => provider.parte2.complejidad1 = value,
      ),
      _ComplejidadWidget(
        numero: '2',
        frase1: 'Tuyo esto',
        frase2: 'Este es tuyo',
        groupValue: provider.parte2.complejidad2,
        onChanged: (value) => provider.parte2.complejidad2 = value,
      ),
      _ComplejidadWidget(
        numero: '3',
        frase1: 'Tito malo',
        frase2: 'Soy malo',
        groupValue: provider.parte2.complejidad3,
        onChanged: (value) => provider.parte2.complejidad3 = value,
      ),
      _ComplejidadWidget(
        numero: '4',
        frase1: 'Pepe uvas',
        frase2: 'Quiero uvas',
        groupValue: provider.parte2.complejidad4,
        onChanged: (value) => provider.parte2.complejidad4 = value,
      ),
      _ComplejidadWidget(
        numero: '5',
        frase1: 'Agua vamos',
        frase2: 'Vamos al agua',
        groupValue: provider.parte2.complejidad5,
        onChanged: (value) => provider.parte2.complejidad5 = value,
      ),
      _ComplejidadWidget(
        numero: '6',
        frase1: 'A silla',
        frase2: 'En la silla',
        groupValue: provider.parte2.complejidad6,
        onChanged: (value) => provider.parte2.complejidad6 = value,
      ),
      _ComplejidadWidget(
        numero: '7',
        frase1: 'Pollo no',
        frase2: 'No quiero pollo',
        groupValue: provider.parte2.complejidad7,
        onChanged: (value) => provider.parte2.complejidad7 = value,
      ),
      _ComplejidadWidget(
        numero: '8',
        frase1: 'Paloma llorando',
        frase2: 'Paloma está llorando',
        groupValue: provider.parte2.complejidad8,
        onChanged: (value) => provider.parte2.complejidad8 = value,
      ),
      _ComplejidadWidget(
        numero: '9',
        frase1: 'Mío lápiz',
        frase2: 'Éste es mi lápiz',
        groupValue: provider.parte2.complejidad9,
        onChanged: (value) => provider.parte2.complejidad9 = value,
      ),
      _ComplejidadWidget(
        numero: '10',
        frase1: 'Más leche',
        frase2: 'Dame más leche',
        groupValue: provider.parte2.complejidad10,
        onChanged: (value) => provider.parte2.complejidad10 = value,
      ),
      _ComplejidadWidget(
        numero: '11',
        frase1: 'Papo mami',
        frase2: 'El zapato es de mami',
        groupValue: provider.parte2.complejidad11,
        onChanged: (value) => provider.parte2.complejidad11 = value,
      ),
      _ComplejidadWidget(
        numero: '12',
        frase1: 'No aquí',
        frase2: 'Ése no está aquí',
        groupValue: provider.parte2.complejidad12,
        onChanged: (value) => provider.parte2.complejidad12 = value,
      ),
      _ComplejidadWidget(
        numero: '13',
        frase1: 'Rompió globo',
        frase2: 'Se rompió el globo',
        groupValue: provider.parte2.complejidad13,
        onChanged: (value) => provider.parte2.complejidad13 = value,
      ),
      _ComplejidadWidget(
        numero: '14',
        frase1: 'Leche caliente',
        frase2: 'La leche está caliente',
        groupValue: provider.parte2.complejidad14,
        onChanged: (value) => provider.parte2.complejidad14 = value,
      ),
      _ComplejidadWidget(
        numero: '15',
        frase1: 'Duele panza',
        frase2: 'Me duele la panza',
        groupValue: provider.parte2.complejidad15,
        onChanged: (value) => provider.parte2.complejidad15 = value,
      ),
      _ComplejidadWidget(
        numero: '16',
        frase1: 'Gua-gua grande',
        frase2: 'Tengo un perro grande',
        groupValue: provider.parte2.complejidad16,
        onChanged: (value) => provider.parte2.complejidad16 = value,
      ),
      _ComplejidadWidget(
        numero: '17',
        frase1: 'Calle allá está',
        frase2: 'Allá está la calle',
        groupValue: provider.parte2.complejidad17,
        onChanged: (value) => provider.parte2.complejidad17 = value,
      ),
      _ComplejidadWidget(
        numero: '18',
        frase1: 'Puse a mano',
        frase2: 'Lo puse en mi mano',
        groupValue: provider.parte2.complejidad18,
        onChanged: (value) => provider.parte2.complejidad18 = value,
      ),
      _ComplejidadWidget(
        numero: '19',
        frase1: 'Acabó agua',
        frase2: 'Se me acabó el agua',
        groupValue: provider.parte2.complejidad19,
        onChanged: (value) => provider.parte2.complejidad19 = value,
      ),
      _ComplejidadWidget(
        numero: '20',
        frase1: 'Fue casa',
        frase2: 'Se fue a su casa',
        groupValue: provider.parte2.complejidad20,
        onChanged: (value) => provider.parte2.complejidad20 = value,
      ),
      _ComplejidadWidget(
        numero: '21',
        frase1: 'Silla subir',
        frase2: 'Me quiero subir a la silla',
        groupValue: provider.parte2.complejidad21,
        onChanged: (value) => provider.parte2.complejidad21 = value,
      ),
      _ComplejidadWidget(
        numero: '22',
        frase1: 'Marta papá',
        frase2: 'Quiero ir con papá',
        groupValue: provider.parte2.complejidad22,
        onChanged: (value) => provider.parte2.complejidad22 = value,
      ),
      _ComplejidadWidget(
        numero: '23',
        frase1: 'Bravo tello circo',
        frase2: 'Dije bravo en el circo',
        groupValue: provider.parte2.complejidad23,
        onChanged: (value) => provider.parte2.complejidad23 = value,
      ),
      _ComplejidadWidget(
        numero: '24',
        frase1: 'Papá calle',
        frase2: 'Papá se fue a trabajar',
        groupValue: provider.parte2.complejidad24,
        onChanged: (value) => provider.parte2.complejidad24 = value,
      ),
      _ComplejidadWidget(
        numero: '25',
        frase1: 'Ya puse',
        frase2: 'Ya se lo puse',
        groupValue: provider.parte2.complejidad25,
        onChanged: (value) => provider.parte2.complejidad25 = value,
      ),
      _ComplejidadWidget(
        numero: '26',
        frase1: 'Chalo osito coche',
        frase2: 'Chalo dejó el osito en el coche',
        groupValue: provider.parte2.complejidad26,
        onChanged: (value) => provider.parte2.complejidad26 = value,
      ),
      _ComplejidadWidget(
        numero: '27',
        frase1: 'Lápiz dibujar',
        frase2: 'Dibujo con el lápiz',
        groupValue: provider.parte2.complejidad27,
        onChanged: (value) => provider.parte2.complejidad27 = value,
      ),
      _ComplejidadWidget(
        numero: '28',
        frase1: 'Ya pinté',
        frase2: 'Ya acabé de pintar',
        groupValue: provider.parte2.complejidad28,
        onChanged: (value) => provider.parte2.complejidad28 = value,
      ),
      _ComplejidadWidget(
        numero: '29',
        frase1: 'Nene rompió bici Danny',
        frase2: 'El niño rompió la bici de Danny',
        groupValue: provider.parte2.complejidad29,
        onChanged: (value) => provider.parte2.complejidad29 = value,
      ),
      _ComplejidadWidget(
        numero: '30',
        frase1: 'Pone no',
        frase2: 'No lo pongas',
        groupValue: provider.parte2.complejidad30,
        onChanged: (value) => provider.parte2.complejidad30 = value,
      ),
      _ComplejidadWidget(
        numero: '31',
        frase1: 'Vamos comer papas carne',
        frase2: 'Vamos a comer papas y carne',
        groupValue: provider.parte2.complejidad31,
        onChanged: (value) => provider.parte2.complejidad31 = value,
      ),
      _ComplejidadWidget(
        numero: '32',
        frase1: 'Niño llora cayó',
        frase2: 'El niño llora porque se cayó',
        groupValue: provider.parte2.complejidad32,
        onChanged: (value) => provider.parte2.complejidad32 = value,
      ),
      _ComplejidadWidget(
        numero: '33',
        frase1: 'Mamá nene compra',
        frase2: 'Mamá y nene fueron a comprar',
        groupValue: provider.parte2.complejidad33,
        onChanged: (value) => provider.parte2.complejidad33 = value,
      ),
      _ComplejidadWidget(
        numero: '34',
        frase1: 'Abre dame galleta',
        frase2: 'Abre la caja y dame una galleta',
        groupValue: provider.parte2.complejidad34,
        onChanged: (value) => provider.parte2.complejidad34 = value,
      ),
      _ComplejidadWidget(
        numero: '35',
        frase1: 'No toca, quemas',
        frase2: 'No lo toques porque te quemas',
        groupValue: provider.parte2.complejidad35,
        onChanged: (value) => provider.parte2.complejidad35 = value,
      ),
      _ComplejidadWidget(
        numero: '36',
        frase1: 'Quiero libro papá',
        frase2: 'Quiero el libro que compró papá',
        groupValue: provider.parte2.complejidad36,
        onChanged: (value) => provider.parte2.complejidad36 = value,
      ),
      _ComplejidadWidget(
        numero: '37',
        frase1: 'Pongo agua flores',
        frase2: 'Pongo agua para que crezcan las flores',
        groupValue: provider.parte2.complejidad37,
        onChanged: (value) => provider.parte2.complejidad37 = value,
      ),
    ];

    final int numRenglonesFrases = (frases.length / numColumnas).ceil();

    List<Column> columnasFrases = [];

    for (var i = 0; i < numColumnas; i++) {
      int startIndex = i * numRenglonesFrases;
      int finalIndex = startIndex + numRenglonesFrases;
      if (i == numColumnas - 1) finalIndex = frases.length;
      final columna = Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: frases.sublist(startIndex, finalIndex),
      );
      columnasFrases.add(columna);
    }

    return CustomCard(
      title: 'C. Complejidad de frases',
      child: Column(
        children: [
          Text(
            'A continuación encontrará pares de frases. Por favor, señale la que más se parezca a la forma como habla su hijo(a) en este momento. Si su hijo(a) usa frases más largas o complicadas de las que vienen en los ejemplos, por favor marque la segunda frase. El (la) niño(a) no tiene que decir exactamente la misma frase; lo que le pedimos es que marque la frase que se parezca más a la manera en que su hijo(a) habla.',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnasFrases,
          )
        ],
      ),
    );
  }
}

class _ComplejidadWidget extends StatefulWidget {
  const _ComplejidadWidget({
    Key? key,
    required this.numero,
    required this.frase1,
    required this.frase2,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String numero;
  final String frase1;
  final String frase2;
  final int? groupValue;
  final void Function(int) onChanged;

  @override
  State<_ComplejidadWidget> createState() => __ComplejidadWidgetState();
}

class __ComplejidadWidgetState extends State<_ComplejidadWidget> {
  int localGroupValue = 2;

  @override
  void initState() {
    if (widget.groupValue != null) {
      localGroupValue = widget.groupValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final widgetWidth = size.width > 860 ? 278.0 : 200.0;
    final widgetHeight = size.width > 860 ? 50.0 : 60.0;

    final CDI2Provider provider = Provider.of<CDI2Provider>(
      context,
      listen: false,
    );

    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 5),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFDDDDDD)),
                  left: BorderSide(color: Color(0xFFDDDDDD)),
                  right: BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
              width: widgetWidth,
              height: widgetHeight,
              child: ListTile(
                title: Text(
                  widget.frase1,
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                trailing: Radio(
                  value: 0,
                  activeColor: AppTheme.of(context).secondaryColor,
                  groupValue: localGroupValue,
                  onChanged: (value) {
                    if (value == null) return;
                    widget.onChanged(value);
                    provider.setComplejidad(widget.numero, value);
                    setState(() {
                      localGroupValue = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFFDDDDDD)),
                  left: BorderSide(color: Color(0xFFDDDDDD)),
                  right: BorderSide(color: Color(0xFFDDDDDD)),
                ),
              ),
              width: widgetWidth,
              height: widgetHeight,
              child: ListTile(
                title: Text(
                  widget.frase2,
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                trailing: Radio(
                  value: 1,
                  activeColor: AppTheme.of(context).secondaryColor,
                  groupValue: localGroupValue,
                  onChanged: (value) {
                    if (value == null) return;
                    widget.onChanged(value);
                    setState(() {
                      localGroupValue = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Text(
            '${widget.numero}.-',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppTheme.of(context).secondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
