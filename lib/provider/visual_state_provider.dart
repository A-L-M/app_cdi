import 'package:flutter/material.dart';

class VisualStateProvider extends ChangeNotifier {
  //OPCIONES MENU:
  List<bool> isTaped = [
    true, //Bebes
    false, //CDI 1
    false, //CDI 2
    false, //Usuarios
  ];

  void setTapedOption(int index) {
    for (var i = 0; i < isTaped.length; i++) {
      isTaped[i] = false;
    }
    isTaped[index] = true;
  }
}
