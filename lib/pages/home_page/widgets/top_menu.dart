import 'package:app_cdi/helpers/constants.dart';
import 'package:app_cdi/pages/home_page/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_cdi/pages/home_page/widgets/dropdown_button.dart';

class TopMenuWidget extends StatelessWidget {
  const TopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > mobileSize) {
        return const TopMenuBodyDesktop();
      } else {
        return const TopMenuBodyMobile();
      }
    });
  }
}

class TopMenuBodyMobile extends StatelessWidget {
  const TopMenuBodyMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: const BoxDecoration(
        color: Color(0xFF333333),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              'Laboratorio de Infantes',
              style: GoogleFonts.kaushanScript(
                color: const Color(0xFFD1AC2B),
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          const CustomMenuButton(),
        ],
      ),
    );
  }
}

class TopMenuBodyDesktop extends StatelessWidget {
  const TopMenuBodyDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            portalFollower: Container(
              height: 50,
              width: 50,
              color: Colors.red,
            ),
          ),
          const Spacer(),
          CustomDropdownButton(
            title: 'Iniciar Sesión',
            portalFollower: const LoginForm(),
          ),
        ],
      ),
    );
  }
}

class CustomMenuButton extends StatefulWidget {
  const CustomMenuButton({Key? key}) : super(key: key);

  @override
  State<CustomMenuButton> createState() => _CustomMenuButtonState();
}

class _CustomMenuButtonState extends State<CustomMenuButton> {
  Color buttonColor = const Color(0xFFD1AC2B);

  Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        buttonColor = lighten(buttonColor, 15);
        setState(() {});
      },
      onExit: (event) {
        buttonColor = const Color(0xFFD1AC2B);
        setState(() {});
      },
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text(
                'MENU',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 3),
              const Icon(
                Icons.menu,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
