import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    Key? key,
    this.initialOption,
    this.hint,
    required this.options,
    required this.onChanged,
    this.validator,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    this.textStyle,
    this.elevation,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.margin,
    this.hidesUnderline = false,
    this.onlyBottomBorder = false,
  }) : super(key: key);

  final String? initialOption;
  final Widget? hint;
  final List<String> options;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? fillColor;
  final TextStyle? textStyle;
  final int? elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;
  final bool onlyBottomBorder;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropDownValue;
  List<String> get effectiveOptions => widget.options.isEmpty ? ['Opción'] : widget.options;

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.initialOption ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = DropdownButtonFormField<String>(
      menuMaxHeight: widget.height,
      value: effectiveOptions.contains(dropDownValue) ? dropDownValue : null,
      hint: widget.hint,
      items: effectiveOptions
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: widget.textStyle,
                ),
              ))
          .toList(),
      validator: widget.validator,
      elevation: widget.elevation ?? 8,
      onChanged: (value) {
        dropDownValue = value;
        widget.onChanged(value);
      },
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.of(context).primaryColor),
        ),
      ),
      icon: widget.icon,
      iconEnabledColor: AppTheme.of(context).primaryColor,
      dropdownColor: widget.fillColor,
      focusColor: Colors.transparent,
    );
    final childWidget = Padding(
      padding: widget.margin,
      child: dropdownWidget,
    );
    if (widget.width != null) {
      return SizedBox(
        width: widget.width,
        child: childWidget,
      );
    }
    return childWidget;
  }
}
