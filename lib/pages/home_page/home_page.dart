import 'package:app_cdi/pages/home_page/widgets/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/home_page/widgets/inventario_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/baby.png'),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > mobileSize) {
              return const HomePageBodyDesktop();
            } else {
              return const HomePageBodyMobile();
            }
          }),
        ),
      ),
    );
  }
}

class HomePageBodyMobile extends StatelessWidget {
  const HomePageBodyMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const TopMenuWidget(),
          Container(
            padding: const EdgeInsets.only(top: 100),
            margin: const EdgeInsets.only(bottom: 25),
            child: const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontFamily: 'DroidSerif',
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 50,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            alignment: Alignment.center,
            child: Text(
              'LABORATORIO DE INFANTES',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          InventarioButton(label: 'INVENTARIO I', onTap: () {}),
          const SizedBox(height: 20),
          InventarioButton(label: 'INVENTARIO II', onTap: () {}),
        ],
      ),
    );
  }
}

class HomePageBodyDesktop extends StatelessWidget {
  const HomePageBodyDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopMenuWidget(),
        Container(
          padding: const EdgeInsets.only(top: 125),
          margin: const EdgeInsets.only(bottom: 25),
          child: const Text(
            '¡Bienvenido!',
            style: TextStyle(
              fontFamily: 'DroidSerif',
              fontStyle: FontStyle.italic,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 70,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: Text(
            'LABORATORIO DE INFANTES',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 75,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InventarioButton(label: 'INVENTARIO I', onTap: () {}),
            const SizedBox(width: 50),
            InventarioButton(label: 'INVENTARIO II', onTap: () {}),
          ],
        ),
      ],
    );
  }
}
