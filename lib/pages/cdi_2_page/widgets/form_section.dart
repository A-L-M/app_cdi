import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/pages/cdi_2_page/widgets/palabras_section.dart';
import 'package:app_cdi/pages/widgets/custom_card.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FormSection extends StatefulWidget {
  const FormSection({
    Key? key,
    required this.title,
    required this.palabras,
  }) : super(key: key);

  final String title;
  final List<PalabraCDI2> palabras;

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  @override
  Widget build(BuildContext context) {
    // final CDI2Provider provider = Provider.of<CDI2Provider>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomCard(
          title: widget.title,
          contentPadding: EdgeInsets.zero,
          textAlign: Alignment.centerLeft,
          child: PalabrasSection(
            palabras: widget.palabras,
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 20, right: 10),
        //   child: Align(
        //     alignment: Alignment.centerRight,
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Text(
        //               'ICPLIM: Total C = ',
        //               style: GoogleFonts.robotoSlab(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.normal,
        //                 color: const Color(0xFF2B2B2B),
        //               ),
        //             ),
        //             Text(
        //               provider.getTotalC(widget.palabras).toString(),
        //               style: GoogleFonts.robotoSlab(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.w700,
        //                 color: const Color(0xFF2B2B2B),
        //               ),
        //             ),
        //             const SizedBox(width: 5),
        //             Text(
        //               'Total C/D = ',
        //               style: GoogleFonts.robotoSlab(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.normal,
        //                 color: const Color(0xFF2B2B2B),
        //               ),
        //             ),
        //             Text(
        //               provider.getTotalCD(widget.palabras).toString(),
        //               style: GoogleFonts.robotoSlab(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.bold,
        //                 color: const Color(0xFF2B2B2B),
        //               ),
        //             ),
        //           ],
        //         ),
        //         Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Text(
        //               'CDI-II: Total Dice = ',
        //               style: GoogleFonts.robotoSlab(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.normal,
        //                 color: const Color(0xFF2B2B2B),
        //               ),
        //             ),
        //             Text(
        //               provider.getTotalD(widget.palabras).toString(),
        //               style: GoogleFonts.robotoSlab(
        //                 fontSize: 14,
        //                 fontWeight: FontWeight.bold,
        //                 color: const Color(0xFF2B2B2B),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
