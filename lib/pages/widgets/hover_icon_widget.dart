import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';

class HoverIconWidget extends StatefulWidget {
  const HoverIconWidget({
    Key? key,
    required this.icon,
    this.isRed = false,
    this.size = 30,
  }) : super(key: key);

  final IconData icon;
  final bool isRed;
  final double size;

  @override
  State<HoverIconWidget> createState() => _HoverIconWidgetState();
}

class _HoverIconWidgetState extends State<HoverIconWidget> {
  Color iconColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        setState(() {
          if (widget.isRed) {
            iconColor = Colors.red;
          } else {
            iconColor = AppTheme.of(context).primaryColor;
          }
        });
      },
      onExit: (_) {
        setState(() {
          iconColor = Colors.grey;
        });
      },
      child: Icon(
        widget.icon,
        color: iconColor,
        size: widget.size,
      ),
    );
  }
}
