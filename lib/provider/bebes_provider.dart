import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:app_cdi/helpers/functions/remove_diacritics.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

class BebesProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<Bebe> bebes = [];
  List<Bebe> bebesFiltrados = [];

  //EDITAR USUARIOS
  Bebe? bebeEditado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "bebe_id";

  final numIdentificacionController = TextEditingController();
  final nombreCuidadorController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final fechaNacimientoController = TextEditingController();

  Sexo? sexo;
  DateTime? fechaNacimiento;

  Future<void> updateState() async {
    await getBebes();
  }

  Future<void> getBebes() async {
    try {
      final res = await supabase.from('bebe').select().order(orden, ascending: true);

      if (res == null) {
        log('Error en getBebes()');
        return;
      }

      //TODO: ordenar bebes por fecha de registro

      bebes = (res as List<dynamic>).map((usuario) => Bebe.fromJson(jsonEncode(usuario))).toList();

      bebesFiltrados = [...bebes];

      llenarPlutoGrid(bebes);
    } catch (e) {
      log('Error en getBebes() - $e');
    }
  }

  void llenarPlutoGrid(List<Bebe> bebes) {
    rows.clear();
    bebesFiltrados = [...bebes];
    for (Bebe bebe in bebes) {
      rows.add(
        PlutoRow(
          cells: {
            'id': PlutoCell(value: bebe.bebeId),
            'cuidador': PlutoCell(value: bebe.nombreCuidador),
            'nombre': PlutoCell(value: bebe.nombre),
            'apellido_paterno': PlutoCell(value: bebe.apellidoPaterno),
            'apellido_materno': PlutoCell(value: bebe.apellidoMaterno ?? ''),
            'sexo': PlutoCell(value: Bebe.convertToString(bebe.sexo)),
            'fecha_nacimiento': PlutoCell(value: bebe.fechaNacimiento.parseToString('yyyy/MM/dd')),
            'acciones': PlutoCell(value: bebe.bebeId.toString()),
          },
        ),
      );
    }
    if (stateManager != null) stateManager!.notifyListeners();
    notifyListeners();
  }

  void filtrarBebes() {
    //Revisar que exista busqueda
    if (busquedaController.text.isEmpty) {
      bebesFiltrados = [...bebes];
      llenarPlutoGrid(bebesFiltrados);
      return;
    }

    //Revisar que se este buscando un id
    final int? id = int.tryParse(busquedaController.text);
    if (id != null) {
      bebesFiltrados = bebes.where((bebe) => bebe.bebeId.toString().contains(id.toString())).toList();
      llenarPlutoGrid(bebesFiltrados);
      return;
    }

    //Revisar que se este buscando un nombre
    final String busqueda = removeDiacritics(busquedaController.text).toLowerCase();
    bebesFiltrados = bebes.where((bebe) {
      final String nombreBebe = removeDiacritics(bebe.nombreCompleto).toLowerCase();
      if (nombreBebe.contains(busqueda)) return true;
      return false;
    }).toList();

    llenarPlutoGrid(bebesFiltrados);
  }

  Bebe? initBebe() {
    final int? bebeId = int.tryParse(numIdentificacionController.text);
    if (bebeId == null || sexo == null || fechaNacimiento == null) return null;
    return Bebe(
      bebeId: bebeId,
      nombreCuidador: nombreCuidadorController.text,
      nombre: nombreController.text,
      apellidoPaterno: apellidoPaternoController.text,
      apellidoMaterno: apellidoMaternoController.text,
      sexo: sexo!,
      fechaNacimiento: fechaNacimiento!,
    );
  }

  Future<bool> registrarBebe() async {
    try {
      final bebe = initBebe();
      if (bebe == null) return false;
      await supabase.from('bebe').insert(bebe.toMap());
      bebes.add(bebe);
      llenarPlutoGrid(bebes);
      return true;
    } catch (e) {
      log('Error en registrarBebe() - $e');
      return false;
    }
  }

  void setSexo(Sexo selected) {
    sexo = selected;
    notifyListeners();
  }

  void clearAll({bool notify = true}) {
    numIdentificacionController.clear();
    nombreController.clear();
    nombreCuidadorController.clear();
    apellidoPaternoController.clear();
    apellidoMaternoController.clear();
    fechaNacimientoController.clear();
    sexo = null;
    fechaNacimiento = null;
    if (notify) notifyListeners();
  }

  Future<bool> borrarBebe(int bebeId) async {
    try {
      final res = await supabase.rpc('borrar_bebe', params: {'id': bebeId});
      bebes.removeWhere((bebe) => bebe.bebeId == bebeId);
      llenarPlutoGrid(bebes);
      return res;
    } catch (e) {
      log('Error en borrarBebe() - $e');
      return false;
    }
  }

  void initEditarBebe(Bebe bebe) {
    numIdentificacionController.text = bebe.bebeId.toString();
    nombreCuidadorController.text = bebe.nombreCuidador;
    nombreController.text = bebe.nombre;
    apellidoPaternoController.text = bebe.apellidoPaterno;
    apellidoMaternoController.text = bebe.apellidoMaterno ?? '';
    sexo = bebe.sexo;
    fechaNacimiento = bebe.fechaNacimiento;
    fechaNacimientoController.text = fechaNacimiento.parseToString('yyyy/MM/dd');
  }

  Future<bool> editarBebe() async {
    try {
      final bebe = initBebe();
      if (bebe == null) return false;
      await supabase.from('bebe').update(bebe.toMap()).eq(
            'bebe_id',
            bebe.bebeId,
          );
      await getBebes();
      return true;
    } catch (e) {
      log('Error en editarBebe() - $e');
      return false;
    }
  }

  @override
  void dispose() {
    numIdentificacionController.dispose();
    nombreCuidadorController.dispose();
    nombreController.dispose();
    apellidoPaternoController.dispose();
    apellidoMaternoController.dispose();
    fechaNacimientoController.dispose();
    super.dispose();
  }
}
