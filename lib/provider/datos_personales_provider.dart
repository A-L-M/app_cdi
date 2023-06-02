import 'package:flutter/material.dart';

class DatosPersonalesProvider extends ChangeNotifier {
  final numIdentificacionController = TextEditingController();
  final nombreCuidadorController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final buscarController = TextEditingController();

  String? sexo;
  DateTime? fechaNacimiento;
  DateTime? fechaCita;

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
