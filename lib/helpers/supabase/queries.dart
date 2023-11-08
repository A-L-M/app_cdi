import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseQueries {
  static Future<Usuario?> getCurrentUserData() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final PostgrestFilterBuilder query = supabase.from('users').select().eq('perfil_usuario_id', user.id);

      final res = await query;

      final userProfile = res[0];
      userProfile['id'] = user.id;
      userProfile['email'] = user.email!;

      final usuario = Usuario.fromMap(userProfile);

      return usuario;
    } catch (e) {
      log('Error en getCurrentUserData() - $e');
      return null;
    }
  }
}
