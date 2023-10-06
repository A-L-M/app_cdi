import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/bebe.dart';
import 'package:flutter/material.dart';

class DatosPersonalesProvider extends ChangeNotifier {
  final numIdentificacionController = TextEditingController();
  final nombreCuidadorController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final buscarController = TextEditingController();
  final fechaNacimientoController = TextEditingController();

  Sexo? sexo;
  DateTime? fechaNacimiento;
  DateTime? fechaCita = DateTime.now();
  String? id;
  Bebe? bebe;

  void setSexo(Sexo selected) {
    sexo = selected;
    notifyListeners();
  }

  void clearAll() {
    numIdentificacionController.clear();
    nombreController.clear();
    nombreCuidadorController.clear();
    apellidoPaternoController.clear();
    apellidoMaternoController.clear();
    buscarController.clear();
    fechaNacimientoController.clear();
    sexo = null;
    fechaNacimiento = null;
    fechaCita = null;
  }

  void initBebe() {
    final int? bebeId = int.tryParse(numIdentificacionController.text);
    if (bebeId == null || sexo == null || fechaNacimiento == null) return;
    bebe = Bebe(
      bebeId: bebeId,
      nombreCuidador: nombreCuidadorController.text,
      nombre: nombreController.text,
      apellidoPaterno: apellidoPaternoController.text,
      apellidoMaterno: apellidoMaternoController.text,
      sexo: sexo!,
      fechaNacimiento: fechaNacimiento!,
    );
  }

  void initControllers() {
    if (bebe == null) return;
    numIdentificacionController.text = bebe!.bebeId.toString();
    nombreCuidadorController.text = bebe!.nombreCuidador;
    nombreController.text = bebe!.nombre;
    apellidoPaternoController.text = bebe!.apellidoPaterno;
    apellidoMaternoController.text = bebe!.apellidoMaterno ?? '';
    sexo = bebe!.sexo;
    fechaNacimiento = bebe!.fechaNacimiento;
    fechaNacimientoController.text = fechaNacimiento.parseToString('yyyy/MM/dd');
  }

  Future<bool> registrarBebe() async {
    try {
      initBebe();
      if (bebe == null) return false;
      final res = await supabase.from('bebe').select('bebe_id').eq('bebe_id', bebe!.bebeId);
      final bool bebeExiste = (res as List).isNotEmpty;
      if (bebeExiste) return true;
      await supabase.from('bebe').insert(bebe!.toMap());
      return true;
    } catch (e) {
      log('Error en registrarBebe() - $e');
      return false;
    }
  }

  Future<bool> buscarBebe() async {
    try {
      final res = await supabase.from('bebe').select().eq('bebe_id', buscarController.text);

      if ((res as List).isEmpty) return false;

      bebe = Bebe.fromJson(jsonEncode(res[0]));

      initControllers();
      notifyListeners();
      return true;
    } catch (e) {
      log('Error en buscarBebe() - $e');
      return false;
    }
  }

  Future<int?> registrarCDI1() async {
    try {
      if (fechaCita == null || bebe == null) return null;
      final res = await supabase.rpc('registrar_cdi1', params: {
        'fecha_cita': fechaCita!.toIso8601String(),
        'bebe_id': bebe!.bebeId,
      });
      return res;
    } catch (e) {
      log('Error en registrarCDI1() - $e');
      return null;
    }
  }

  Future<int?> registrarCDI2() async {
    try {
      if (fechaCita == null || bebe == null) return null;
      final res = await supabase.rpc('registrar_cdi2', params: {
        'fecha_cita': fechaCita!.toIso8601String(),
        'bebe_id': bebe!.bebeId,
      });
      return res;
    } catch (e) {
      log('Error en registrarCDI2() - $e');
      return null;
    }
  }

  @override
  void dispose() {
    numIdentificacionController.dispose();
    nombreCuidadorController.dispose();
    nombreController.dispose();
    apellidoPaternoController.dispose();
    apellidoMaternoController.dispose();
    buscarController.dispose();
    fechaNacimientoController.dispose();
    super.dispose();
  }
}
