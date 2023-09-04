import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/models/enums.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/preguntas_lenguaje_widget.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';

class IncisoAWidget extends StatefulWidget {
  const IncisoAWidget({super.key});

  @override
  State<IncisoAWidget> createState() => _IncisoAWidgetState();
}

class _IncisoAWidgetState extends State<IncisoAWidget> {
  final List<String> preguntas = [
    '¿Su hijo(a) ya empezó a combinar palabras, como "papá coche" o "más agua"?',
  ];

  @override
  Widget build(BuildContext context) {
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);
    final size = MediaQuery.of(context).size;

    final cellHeight = size.width > 1145 ? 75.0 : 125.0;
    final titleHeight = size.width > 857 ? 38.0 : 60.0;

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
        dbName: 'acabo',
        valor: provider.parte2.acabo,
        onChanged: (bool value) => provider.parte2.acabo = value,
      ),
      _VerboWidget(
        verbo: 'Acabas',
        dbName: 'acabas',
        valor: provider.parte2.acabas,
        onChanged: (bool value) => provider.parte2.acabas = value,
      ),
      _VerboWidget(
        verbo: 'Acaba',
        dbName: 'acaba',
        valor: provider.parte2.acaba,
        onChanged: (bool value) => provider.parte2.acaba = value,
      ),
      _VerboWidget(
        verbo: 'Acabamos',
        dbName: 'acabamos',
        valor: provider.parte2.acabamos,
        onChanged: (bool value) => provider.parte2.acabamos = value,
      ),
      _VerboWidget(
        verbo: 'Como',
        dbName: 'como',
        valor: provider.parte2.como,
        onChanged: (bool value) => provider.parte2.como = value,
      ),
      _VerboWidget(
        verbo: 'Comes',
        dbName: 'comes',
        valor: provider.parte2.comes,
        onChanged: (bool value) => provider.parte2.comes = value,
      ),
      _VerboWidget(
        verbo: 'Come',
        dbName: 'come',
        valor: provider.parte2.come,
        onChanged: (bool value) => provider.parte2.come = value,
      ),
      _VerboWidget(
        verbo: 'Comemos',
        dbName: 'comemos',
        valor: provider.parte2.comemos,
        onChanged: (bool value) => provider.parte2.comemos = value,
      ),
      _VerboWidget(
        verbo: 'Subo',
        dbName: 'subo',
        valor: provider.parte2.subo,
        onChanged: (bool value) => provider.parte2.subo = value,
      ),
      _VerboWidget(
        verbo: 'Subes',
        dbName: 'subes',
        valor: provider.parte2.subes,
        onChanged: (bool value) => provider.parte2.subes = value,
      ),
      _VerboWidget(
        verbo: 'Sube',
        dbName: 'sube',
        valor: provider.parte2.sube,
        onChanged: (bool value) => provider.parte2.sube = value,
      ),
      _VerboWidget(
        verbo: 'Subimos',
        dbName: 'subimos',
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
    final List<_VerboWidget> pasado = [
      _VerboWidget(
        verbo: 'Acabé',
        dbName: 'acabe',
        valor: provider.parte2.acabe,
        onChanged: (bool value) => provider.parte2.acabe = value,
      ),
      _VerboWidget(
        verbo: 'Acabó',
        dbName: 'acabo2',
        valor: provider.parte2.acabo2,
        onChanged: (bool value) => provider.parte2.acabo2 = value,
      ),
      _VerboWidget(
        verbo: 'Comí',
        dbName: 'comi',
        valor: provider.parte2.comi,
        onChanged: (bool value) => provider.parte2.comi = value,
      ),
      _VerboWidget(
        verbo: 'Comió',
        dbName: 'comio',
        valor: provider.parte2.comio,
        onChanged: (bool value) => provider.parte2.comio = value,
      ),
      _VerboWidget(
        verbo: 'Subí',
        dbName: 'subi',
        valor: provider.parte2.subi,
        onChanged: (bool value) => provider.parte2.subi = value,
      ),
      _VerboWidget(
        verbo: 'Subió',
        dbName: 'subio',
        valor: provider.parte2.subio,
        onChanged: (bool value) => provider.parte2.subio = value,
      ),
    ];

    final int numRenglonesPasado = (pasado.length / numColumnas).ceil();

    List<Column> columnasPasado = [];

    for (var i = 0; i < numColumnas; i++) {
      int startIndex = i * numRenglonesPasado;
      int finalIndex = startIndex + numRenglonesPasado;
      if (i == numColumnas - 1) finalIndex = pasado.length;
      final columna = Column(
        children: pasado.sublist(startIndex, finalIndex),
      );
      columnasPasado.add(columna);
    }

    //ORDENAR
    final List<_VerboWidget> ordenar = [
      _VerboWidget(
        verbo: 'Acaba',
        dbName: 'acaba2',
        valor: provider.parte2.acaba2,
        onChanged: (bool value) => provider.parte2.acaba2 = value,
      ),
      _VerboWidget(
        verbo: 'Acábate (la leche)',
        dbName: 'acabate',
        valor: provider.parte2.acabate,
        onChanged: (bool value) => provider.parte2.acabate = value,
      ),
      _VerboWidget(
        verbo: 'Come',
        dbName: 'come2',
        valor: provider.parte2.come2,
        onChanged: (bool value) => provider.parte2.come2 = value,
      ),
      _VerboWidget(
        verbo: 'Cómete',
        dbName: 'comete',
        valor: provider.parte2.comete,
        onChanged: (bool value) => provider.parte2.comete = value,
      ),
      _VerboWidget(
        verbo: 'Sube',
        dbName: 'sube',
        valor: provider.parte2.sube,
        onChanged: (bool value) => provider.parte2.sube = value,
      ),
      _VerboWidget(
        verbo: 'Súbete',
        dbName: 'subete',
        valor: provider.parte2.subete,
        onChanged: (bool value) => provider.parte2.subete = value,
      ),
    ];

    final int numRenglonesOrdenar = (ordenar.length / numColumnas).ceil();

    List<Column> columnasOrdenar = [];

    for (var i = 0; i < numColumnas; i++) {
      int startIndex = i * numRenglonesOrdenar;
      int finalIndex = startIndex + numRenglonesOrdenar;
      if (i == numColumnas - 1) finalIndex = ordenar.length;
      final columna = Column(
        children: ordenar.sublist(startIndex, finalIndex),
      );
      columnasOrdenar.add(columna);
    }

    //COMBINAR PALABRAS
    final Column columnaPreguntas = Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        preguntas.length,
        (index) => CustomTableCellText(
          label: preguntas[index],
          height: cellHeight,
        ),
      ),
    );

    columnaPreguntas.children.insert(
      0,
      CustomTableCell(
        height: titleHeight,
        width: double.infinity,
      ),
    );

    final rawBody = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: columnaPreguntas),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTableCellText(
                label: 'Todavía no',
                height: titleHeight,
                fontWeight: FontWeight.w700,
              ),
              CustomTableCell(
                height: cellHeight,
                child: Radio(
                  value: RespuestaComprension.todaviaNo,
                  groupValue: provider.parte2.combinaPalabras,
                  activeColor: AppTheme.of(context).secondaryColor,
                  onChanged: (opcion) {
                    if (opcion == null) return;
                    provider.setCombinaPalabras(opcion);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTableCellText(
                label: 'De vez en cuando',
                height: titleHeight,
                fontWeight: FontWeight.w700,
              ),
              CustomTableCell(
                height: cellHeight,
                child: Radio(
                  value: RespuestaComprension.deVezEnCuando,
                  groupValue: provider.parte2.combinaPalabras,
                  activeColor: AppTheme.of(context).secondaryColor,
                  onChanged: (opcion) {
                    if (opcion == null) return;
                    provider.setCombinaPalabras(opcion);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTableCellText(
                label: 'Muchas veces',
                height: titleHeight,
                fontWeight: FontWeight.w700,
              ),
              CustomTableCell(
                height: cellHeight,
                child: Radio(
                  value: RespuestaComprension.muchasVeces,
                  groupValue: provider.parte2.combinaPalabras,
                  activeColor: AppTheme.of(context).secondaryColor,
                  onChanged: (opcion) {
                    if (opcion == null) return;
                    provider.setCombinaPalabras(opcion);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );

    Widget body;

    if (size.width > 600) {
      body = rawBody;
    } else {
      body = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 600,
          child: rawBody,
        ),
      );
    }

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
          const SizedBox(height: 10),
          Text(
            'Para hablar de cosas que ya sucedieron, ¿Cuáles de estas formas usa?',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: columnasPasado,
          ),
          const SizedBox(height: 10),
          Text(
            'Para pedir algo u ordenar, ¿Cuáles de estas formas usa?',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: columnasOrdenar,
          ),
          const SizedBox(height: 20),
          body,
          const SizedBox(height: 20),
          Text(
            'Si contestó "todavía no", no siga llenando este formato. Si contestó "de vez en cuando" o "muchas veces", por favor continúe llenando el formato.',
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2B2B2B),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _VerboWidget extends StatefulWidget {
  const _VerboWidget({
    Key? key,
    required this.verbo,
    required this.dbName,
    required this.valor,
    required this.onChanged,
  }) : super(key: key);

  final String verbo;
  final String dbName;
  final bool valor;
  final void Function(bool) onChanged;

  @override
  State<_VerboWidget> createState() => __VerboWidgetState();
}

class __VerboWidgetState extends State<_VerboWidget> {
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

    final CDI2Provider provider = Provider.of<CDI2Provider>(
      context,
      listen: false,
    );

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
                provider.setVerbo(widget.dbName, value);
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
