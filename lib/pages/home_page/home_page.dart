import 'package:app_cdi/pages/home_page/widgets/dropdown_button.dart';
import 'package:app_cdi/pages/home_page/widgets/inventario_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/baby.png'),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 700) {
            return const HomePageBodyDesktop();
          } else {
            return const HomePageBodyMobile();
          }
        }),
      ),
    );
  }
}

class HomePageBodyMobile extends StatelessWidget {
  const HomePageBodyMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomePageBodyDesktop extends StatelessWidget {
  const HomePageBodyDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          margin: const EdgeInsets.only(bottom: 20, left: 68, right: 68),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Laboratorio de Infantes',
                  style: GoogleFonts.kaushanScript(
                    color: const Color(0xFFD1AC2B),
                    fontSize: 28,
                  ),
                ),
              ),
              CustomDropdownButton(
                title: 'CDI',
                onTap: () {},
              ),
              const Spacer(),
              CustomDropdownButton(
                title: 'Iniciar Sesión',
                onTap: () {},
              ),
            ],
          ),
        ),
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
