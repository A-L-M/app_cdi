import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  bool loginVisible = false;

  void setLoginVisible(bool value) {
    loginVisible = value;
    notifyListeners();
  }

  void changeLoginPortalVisible() {
    loginVisible = !loginVisible;
    notifyListeners();
  }
}
