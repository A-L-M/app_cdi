import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PalabrasSection extends StatefulWidget {
  const PalabrasSection({
    Key? key,
    required this.palabras,
  }) : super(key: key);

  final List<PalabraCDI2> palabras;

  @override
  State<PalabrasSection> createState() => _PalabrasSectionState();
}

class _PalabrasSectionState extends State<PalabrasSection> {
  @override
  Widget build(BuildContext context) {
    final CDI2Provider provider = Provider.of<CDI2Provider>(context);
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

    //numero de renglones
    final int renglones = (widget.palabras.length / numColumnas).ceil();

    //Se divide la lista de palabras para generar las columnas
    List<List<PalabraCDI2>> palabrasSubLists = [];

    for (var i = 0; i < numColumnas; i++) {
      int startIndex = i * renglones;
      int finalIndex = startIndex + renglones;
      if (i == numColumnas - 1) finalIndex = widget.palabras.length;
      palabrasSubLists.add(widget.palabras.sublist(startIndex, finalIndex));
    }

    //Cada columna se genera con una sublista
    final List<Column> columnas = List.generate(palabrasSubLists.length, (index) {
      final List<PalabraCDI2> sublist = palabrasSubLists[index];

      final List<Widget> listaDePalabras = List.generate(
        sublist.length,
        (index) {
          //Se obtiene el objeto Palabra original
          final int i = widget.palabras.indexOf(sublist[index]);
          PalabraCDI2 palabra = widget.palabras[i];

          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFDDDDDD),
              ),
              color: palabra.sombreada ? Colors.grey[300] : null,
            ),
            width: 285.75,
            height: 50,
            child: ListTile(
              title: Text(
                palabra.nombre,
                style: GoogleFonts.robotoSlab(
                  fontSize: 14,
                  decoration: palabra.subrayada ? TextDecoration.underline : null,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF2B2B2B),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio(
                    value: Opcion.comprende,
                    groupValue: palabra.opcion,
                    activeColor: AppTheme.of(context).secondaryColor,
                    toggleable: true,
                    onChanged: (opcion) {
                      if (opcion == null) {
                        provider.borrarPalabra(palabra);
                        return;
                      }
                      provider.setOpcionPalabra(opcion, palabra);
                    },
                  ),
                  Radio(
                    value: Opcion.comprendeYDice,
                    groupValue: palabra.opcion,
                    activeColor: AppTheme.of(context).secondaryColor,
                    toggleable: true,
                    onChanged: (opcion) {
                      if (opcion == null) {
                        provider.borrarPalabra(palabra);
                        return;
                      }
                      provider.setOpcionPalabra(opcion, palabra);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );

      //A cada columna se le asigna una sublista de palabras
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 285.75,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFDDDDDD),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Palabras',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                const Spacer(),
                Text(
                  'C',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'C/D',
                  style: GoogleFonts.robotoSlab(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
                const SizedBox(width: 2),
              ],
            ),
          ),
          ...listaDePalabras,
        ],
      );
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [...columnas],
    );
  }
}
