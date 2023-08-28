import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';

class ListadoCDI2Provider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  List<CDI2> listadoCDI2 = [];

  CDI2? cdi2Editado;

  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  String orden = "cdi2_id";

  Future<void> updateState() async {
    await getListadoCDI2();
  }

  Future<void> getListadoCDI2() async {
    try {
      final query = supabase.from('cdi2_completo').select();

      final res = await query
          .like('nombre_bebe', '%${busquedaController.text}%')
          .order(orden, ascending: true);

      if (res == null) {
        log('Error en getListadoCDI2()');
        return;
      }

      listadoCDI2 = (res as List<dynamic>)
          .map((usuario) => CDI2.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (CDI2 cdi2 in listadoCDI2) {
        rows.add(
          PlutoRow(
            cells: {
              'cdi2_id': PlutoCell(value: cdi2.cdi2Id),
              'bebe_id': PlutoCell(value: cdi2.bebeId),
              'nombre_bebe': PlutoCell(value: cdi2.nombreBebe),
              'created_at':
                  PlutoCell(value: cdi2.createdAt.parseToString('yyyy-MM-dd')),
              'acciones': PlutoCell(value: cdi2.cdi2Id.toString()),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getListadoCDI2() - $e');
    }

    notifyListeners();
  }

  @override
  void dispose() {
    busquedaController.dispose();
    super.dispose();
  }
}
