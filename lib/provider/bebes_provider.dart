import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

class BebesProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<Bebe> bebes = [];

  //EDITAR USUARIOS
  Bebe? bebeEditado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "bebe_id";

  Future<void> updateState() async {
    await getBebes();
  }

  Future<void> getBebes() async {
    try {
      final query = supabase.from('bebe').select();

      final res = await query
          .like('nombre', '%${busquedaController.text}%')
          .order(orden, ascending: true);

      if (res == null) {
        log('Error en getBebes()');
        return;
      }

      bebes = (res as List<dynamic>)
          .map((usuario) => Bebe.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
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
              'fecha_nacimiento': PlutoCell(
                  value: bebe.fechaNacimiento.parseToString('yyyy/MM/dd')),
              'acciones': PlutoCell(value: bebe.bebeId.toString()),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getBebes() - $e');
    }

    notifyListeners();
  }

  @override
  void dispose() {
    busquedaController.dispose();
    super.dispose();
  }
}
