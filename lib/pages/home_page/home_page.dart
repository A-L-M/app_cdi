import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:app_cdi/pages/home_page/widgets/login_form.dart';
import 'package:app_cdi/pages/home_page/widgets/top_menu.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/home_page/widgets/inventario_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final HomePageProvider provider = Provider.of<HomePageProvider>(context);

    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          provider.setLoginVisible(false);
        },
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
          HomePageButton(
              label: 'INVENTARIO I',
              onTap: () {
                context.pushReplacement('/datos-personales',
                    extra: 'INVENTARIO I');
              }),
          const SizedBox(height: 20),
          HomePageButton(
              label: 'INVENTARIO II',
              onTap: () {
                context.pushReplacement('/datos-personales',
                    extra: 'INVENTARIO II');
              }),
        ],
      ),
    );
  }
}

class HomePageBodyDesktop extends StatelessWidget {
  const HomePageBodyDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomePageProvider provider = Provider.of<HomePageProvider>(context);
    return Stack(
      children: [
        Column(
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
                HomePageButton(
                    label: 'INVENTARIO I',
                    onTap: () {
                      context.pushReplacement(
                        '/datos-personales',
                        extra: 'INVENTARIO I',
                      );
                    }),
                const SizedBox(width: 50),
                HomePageButton(
                    label: 'INVENTARIO II',
                    onTap: () {
                      context.pushReplacement(
                        '/datos-personales',
                        extra: 'INVENTARIO II',
                      );
                    }),
              ],
            ),
          ],
        ),
        Positioned(
          right: 35,
          top: 80,
          child: Visibility(
            visible: provider.loginVisible,
            child: const LoginForm(),
          ),
        ),
      ],
    );
  }
}
