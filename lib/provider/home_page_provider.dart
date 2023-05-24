import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  bool loginPortalVisible = false;
  bool cdiPortalVisible = false;

  void setPortalsVisible(bool value) {
    loginPortalVisible = value;
    cdiPortalVisible = value;
    notifyListeners();
  }

  void changeLoginPortalVisible() {
    loginPortalVisible = !loginPortalVisible;
    notifyListeners();
  }

  void changeCdiPortalVisible() {
    cdiPortalVisible = !cdiPortalVisible;
    notifyListeners();
  }
}
