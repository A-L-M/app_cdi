import 'package:flutter/material.dart';

enum Sexo { hombre, mujer }

class DatosPersonalesProvider extends ChangeNotifier {
  final numIdentificacionController = TextEditingController();
  final nombreCuidadorController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final buscarController = TextEditingController();

  Sexo? sexo;
  DateTime? fechaNacimiento;
  DateTime? fechaCita;
  String? id;

  void setSexo(Sexo selected) {
    sexo = selected;
    notifyListeners();
  }

  void clearAll() {
    numIdentificacionController.clear();
    nombreController.clear();
    nombreController.clear();
    apellidoPaternoController.clear();
    apellidoMaternoController.clear();
    buscarController.clear();
    sexo = null;
    fechaNacimiento = null;
    fechaCita = null;
  }

  @override
  void dispose() {
    numIdentificacionController.dispose();
    nombreCuidadorController.dispose();
    nombreController.dispose();
    apellidoPaternoController.dispose();
    apellidoMaternoController.dispose();
    buscarController.dispose();
    super.dispose();
  }
}
