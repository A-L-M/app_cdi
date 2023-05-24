import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownButton extends StatefulWidget {
  const CustomDropdownButton({
    Key? key,
    required this.title,
    this.portalFollower,
    required this.portalVisibility,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Widget? portalFollower;
  final bool portalVisibility;
  final void Function() onTap;

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  Color buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        buttonColor = const Color(0xFFD1AC2B);
        setState(() {});
      },
      onExit: (event) {
        buttonColor = Colors.white;
        setState(() {});
      },
      child: PortalTarget(
        visible: widget.portalVisibility,
        anchor: const Aligned(
          follower: Alignment.topCenter,
          target: Alignment.bottomCenter,
        ),
        portalFollower: widget.portalFollower,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.montserrat(
                    color: buttonColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down_sharp,
                  color: buttonColor,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
