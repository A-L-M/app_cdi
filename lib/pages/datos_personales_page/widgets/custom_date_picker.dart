import 'dart:developer';

import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/string_extension.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Class [CustomDatePicker] help display date picker on web
class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    Key? key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onChanged,
    this.style,
    this.prefix,
    this.dateformat = 'yyyy/MM/dd',
    this.label = '',
    this.validator,
    this.inputFormatters,
    this.controller,
  }) : super(key: key);

  /// The initial date first
  final DateTime? initialDate;

  /// The earliest date the user is permitted to pick or input.
  final DateTime? firstDate;

  /// The latest date the user is permitted to pick or input.
  final DateTime? lastDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime?> onChanged;

  /// The text style of date form field
  final TextStyle? style;

  /// The prefix of date form field
  final Widget? prefix;

  /// The date format will be displayed in date form field
  final String dateformat;

  final String label;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  //DateController
  final TextEditingController? controller;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final FocusNode _focusNode = FocusNode();

  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  late final TextEditingController _controller;

  late DateTime? _selectedDate;
  late DateTime _firstDate;
  late DateTime _lastDate;

  bool _isEnterDateField = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
    }

    _controller.addListener(() {
      DateTime? date;
      try {
        date = DateFormat('yyyy/MM/dd').parse(_controller.text);
      } catch (e) {
        log('Error in date format - $e');
      }
      if (date != null) {
        _selectedDate = date;
      }
      setState(() {});
    });

    _selectedDate = widget.initialDate;
    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2100);

    if (_selectedDate != null) {
      _controller.text = _selectedDate?.parseToString(widget.dateformat) ?? '';
    }

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _controller.text = _selectedDate.parseToString(widget.dateformat);
        widget.onChanged.call(_selectedDate);
        _overlayEntry.remove();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void onChanged(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    _controller.text = _selectedDate.parseToString(widget.dateformat);

    _focusNode.unfocus();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 300,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          // offset: Offset(0.0, size.height + 5.0),
          offset: const Offset(0.0, -250),
          child: TextFieldTapRegion(
            child: Material(
              elevation: 5,
              child: SizedBox(
                height: 250,
                child: CalendarDatePicker(
                  firstDate: _firstDate,
                  lastDate: _lastDate,
                  initialDate: _selectedDate ?? DateTime.now(),
                  onDateChanged: onChanged,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _isEnterDateField = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isEnterDateField = false;
            });
          },
          child: TextFormField(
            focusNode: _focusNode,
            controller: _controller,
            validator: widget.validator,
            decoration: InputDecoration(
              isCollapsed: true,
              isDense: true,
              contentPadding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15,
                bottom: 12.5,
              ),
              alignLabelWithHint: true,
              hintText: widget.dateformat.toLowerCase(),
              hintStyle: GoogleFonts.robotoSlab(
                color: const Color(0xFFBfbfbf),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              errorStyle: GoogleFonts.robotoSlab(
                fontWeight: FontWeight.normal,
                color: Colors.red,
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFCCCCCC),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFCCCCCC),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4.88),
              ),
              focusColor: AppTheme.of(context).primaryColor,
              suffixIcon: _buildPrefixIcon(),
            ),
            onChanged: (dateString) {
              final date = dateString.parseToDateTime(widget.dateformat);
              if (date.isBefore(_firstDate)) {
                _selectedDate = _firstDate;
              } else if (date.isAfter(_lastDate)) {
                _selectedDate = _lastDate;
              } else {
                _selectedDate = date;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPrefixIcon() {
    if (_controller.text.isNotEmpty && _isEnterDateField) {
      return IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          _controller.clear();
          _selectedDate = null;
        },
        splashRadius: 16,
      );
    } else {
      return widget.prefix ?? const Icon(Icons.date_range);
    }
  }
}
